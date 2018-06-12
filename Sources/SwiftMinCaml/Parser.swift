//
//  Parser.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import SwiftParsec

private func binary(
    _ op: ArithOps,
    assoc: Associativity,
    function: @escaping (Expr, Expr) -> Expr
    ) -> Operator<String, (), Expr> {
    
    let opParser = ArithOps.paser *> GenericParser(result: function)
    return .infix(opParser, assoc)
    
}

private func prefix(
    _ op: ArithOps,
    function: @escaping (Expr) -> Expr
    ) -> Operator<String, (), Expr> {
    
    let opParser = ArithOps.paser *> GenericParser(result: function)
    return .prefix(opParser)
}

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
        
        return add.attempt <|> sub.attempt <|> mul.attempt <|> div.attempt
    }()
}

// MARK: -

extension Expr {
    typealias Parser = GenericParser<String, (), Expr>

    private static let opTable: OperatorTable<String, (), Expr> = [
        [
            // -
            prefix(.sub, function: { e in
                return Expr.arithOps(ops: .sub, args: [e])
            }),
            // +
            prefix(.add, function: { e in
                return Expr.arithOps(ops: .add, args: [e])
            })
        ],
        [
            // *
            binary(.mul, assoc: .left) { (lhs, rhs) in
                return Expr.arithOps(ops: .mul, args: [lhs, rhs])
            },
            // /
            binary(.div, assoc: .left) { (lhs, rhs) in
                return Expr.arithOps(ops: .div, args: [lhs, rhs])
            },
        ],
        [
            // -
            binary(.sub, assoc: .left) { (lhs, rhs) in
                return Expr.arithOps(ops: .sub, args: [lhs, rhs])
            },
            // +
            binary(.add, assoc: .left) { (lhs, rhs) in
                return Expr.arithOps(ops: .add, args: [lhs, rhs])
            },
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
        let bool = Const.bool <^> (trueValue <|> falseValue)
        // float
        let float = Const.float <^> lexer.float
        // integer
        let integer = Const.integer <^> lexer.integer

        let const = Expr.const <^> (bool.attempt <|> float.attempt <|> integer)
        
        return GenericParser.recursive { (expr: Parser) in
            // ArithOps
            let arithOps = Expr.opTable.makeExpressionParser { p in
                p.between(openingParen, closingParen) <|> expr
            }
            //FIXME: still not work
            // return arithOps.attempt <|> const
            return const
        }
    }()
}
