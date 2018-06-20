//
//  Lexer.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/19.
//

import Foundation
import CitronKit

typealias Lexer = CitronLexer<(Token, Parser.CitronTokenCode)>

let lexer = Lexer(rules: [
    // Numbers
    .regexPattern("(-)?[0-9]+\\.[0-9]+", { str in
        if let number = Double(str) {
            return (.floatLiteral(number), .FLOAT)
        }
        return nil
    }),
    .regexPattern("(-)?[0-9]+", { str in
        if let number = Int(str) {
            return (.integerLiteral(number), .INT)
        }
        return nil
    }),
    
    // Boolean
    .string("true", (.boolLiteral(true), .BOOL)),
    .string("false", (.boolLiteral(false), .BOOL)),
    
    // Keyword
    .string("if", (.keyword, .IF)),
    .string("then", (.keyword, .THEN)),
    .string("else", (.keyword, .ELSE)),
    .string("let", (.keyword, .LET)),
    .string("rec", (.keyword, .REC)),
    .string("in", (.keyword, .IN)),
    
    // Identifier
    .regexPattern("[a-zA-Z]+[a-zA-Z0-9_]*", { str in
        return (.identifier(str), .IDENTIFIER)
    }),

    // Operators
    .string("+", (.identifier("+"), .ADD)),
    .string("-", (.identifier("-"), .SUB)),
    .string("*", (.identifier("*"), .MUL)),
    .string("/", (.identifier("/"), .DIV)),
    .string("=", (.identifier("="), .EQUAL)),


    // Punctuation
    .string(",", (.punctuation, .COMMA)),
    .string("(", (.punctuation, .L_BR)),
    .string(")", (.punctuation, .R_BR)),

    // Whitespace
    .regexPattern("\\s", { _ in nil })
])
