//
//  Parser.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import SwiftParsec

// MARK: - ArithOps

extension ArithOps {
    var symbol: String {
        switch self {
        case .add: return "+"
        case .sub: return "-"
        case .mul: return "*"
        case .div: return "/"
        }
    }
}

// MARK: - Expr

extension Expr {
    typealias Parser = GenericParser<String, (), Expr>

    private static func binary( _ op: ArithOps, assoc: Associativity) -> Operator<String, (), Expr> {
        let function = { (lhs: Expr, rhs: Expr) in Expr.arithOps(ops: op, args: [lhs, rhs]) }
        let opParser = StringParser.string(op.symbol) *> GenericParser(result: function)
        return .infix(opParser, assoc)
    }

    private static func prefix(_ op: ArithOps) -> Operator<String, (), Expr> {
        let function = { (e: Expr) -> Expr in
            // workaround ... so messy
            if let f = e.asConst?.asFloat, op.isSub {
                return Expr.const(const: Const.float(-f))
            }
            if let i = e.asConst?.asInteger, op.isSub {
                return Expr.const(const: Const.integer(-i))
            }
            return Expr.arithOps(ops: op, args: [e])
        }
        let opParser = StringParser.string(op.symbol) *> GenericParser(result: function)
        return .prefix(opParser)
    }

    private static let opTable: OperatorTable<String, (), Expr> = [
        [
            prefix(.sub), // -
            prefix(.add) // +
        ],
        [
            binary(.mul, assoc: .left), // *
            binary(.div, assoc: .left)  // /
        ],
        [
            binary(.sub, assoc: .left), // -
            binary(.add, assoc: .left)  // +
        ]
    ]
    
    static let parser: Parser = {
        let minCaml = LanguageDefinition<()>.javaStyle // needs MLStyle...
        let lexer = GenericTokenParser(languageDefinition: minCaml)
        
        let symbol = lexer.symbol
        let stringLiteral = lexer.stringLiteral

        let openingParen = StringParser.character("(")
        let closingParen = StringParser.character(")")
        
        // Const
        // bool
        let trueValue = symbol("true") *> GenericParser(result: true)
        let falseValue = symbol("false") *> GenericParser(result: false)
        let bool = Const.bool <^> (trueValue.attempt <|> falseValue)
        // float
        let float = Const.float <^> lexer.float
        // integer
        let integer = Const.integer <^> lexer.integer

        let const = Expr.const <^> (bool.attempt <|> float.attempt <|> integer)
        
        // Var
        let variable = Expr.var <^> (Var.fromString <^> lexer.identifier)
        

        return Parser.recursive { expr in
            // ArithOps
            let arithOps = Expr.opTable.makeExpressionParser { p in
                p.between(openingParen, closingParen).attempt <|> const
            }

            // Call
            // FIXME: Support high order function
            let apply = variable >>- { name in
                expr.many1 >>- { args in
                    return GenericParser(result: Expr.apply(function: name, args: args))
                }
            }
            return apply.attempt <|> arithOps.attempt <|> const.attempt <|> variable
        }
    }()
}
