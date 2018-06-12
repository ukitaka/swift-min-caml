//
//  Parser.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import SwiftParsec

typealias Parser = GenericParser<String, (), Expr>

extension Expr {
    static let parser: Parser = {
        let minCaml = LanguageDefinition<()>.javaStyle // needs MLStyle...
        let lexer = GenericTokenParser(languageDefinition: minCaml)
        
        let symbol = lexer.symbol
        let stringLiteral = lexer.stringLiteral
        
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

        return const
//        fatalError("Not implemented yet")
        
    }()
}
