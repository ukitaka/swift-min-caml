//
//  Parser.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import SwiftParsec

// MARK: -

extension ArithOps {
    typealias Parser = GenericParser<String, (), ArithOps>
    
    static let paser: GenericParser<String, (), ArithOps> = {
        let minCaml = LanguageDefinition<()>.javaStyle // needs MLStyle...
        let lexer = GenericTokenParser(languageDefinition: minCaml)
        
        let symbol = lexer.symbol
        let add = symbol("+") *> Parser(result: .add)
        let sub = symbol("-") *> Parser(result: .sub)
        let mul = symbol("*") *> Parser(result: .mul)
        let div = symbol("/") *> Parser(result: .div)
        
        return add.attempt <|> sub.attempt <|> mul.attempt <|> div
    }()
}

// MARK: -

extension Expr {
    typealias Parser = GenericParser<String, (), Expr>

    private static func binary( _ op: ArithOps, assoc: Associativity) -> Operator<String, (), Expr> {
        let function = { (lhs: Expr, rhs: Expr) in Expr.arithOps(ops: op, args: [lhs, rhs]) }
        let opParser = ArithOps.paser *> GenericParser(result: function)
        return .infix(opParser, assoc)
    }

    private static func prefix(_ op: ArithOps) -> Operator<String, (), Expr> {
        let function = { (e: Expr) in Expr.arithOps(ops: op, args: [e]) }
        let opParser = ArithOps.paser *> GenericParser(result: function)
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
        
        return Parser.recursive { expr in
            // ArithOps
            let arithOps = Expr.opTable.makeExpressionParser { p in
                p.between(openingParen, closingParen).attempt <|> const.attempt <|> expr
            }
            return arithOps.attempt <|> const
        }
    }()
}
