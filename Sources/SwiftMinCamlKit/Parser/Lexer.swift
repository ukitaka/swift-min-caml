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
    .string("Array.create", (.keyword, .ARRAY_CREATE)),

    // Identifier
    .regexPattern("[a-zA-Z]+[a-zA-Z0-9_]*", { str in
        return (.identifier(str), .IDENTIFIER)
    }),

    // Operators
    .string("<-", (.identifier("<-"), .LEFT_ARROW)),
    .string("+", (.identifier("+"), .ADD)),
    .string("-", (.identifier("-"), .SUB)),
    .string("*.", (.identifier("*"), .MUL)),
    .string("/.", (.identifier("/"), .DIV)),
    .string("-.", (.identifier("-"), .F_MINUS)),
    .string("+.", (.identifier("+"), .F_ADD)),
    .string("-.", (.identifier("-"), .F_SUB)),
    .string("*.", (.identifier("*"), .F_MUL)),
    .string("/.", (.identifier("/"), .F_DIV)),
    .string("=", (.identifier("="), .EQUAL)),
    .string("-", (.identifier("-"), .MINUS)),
    .string("!", (.identifier("!"), .NOT)),
    .string("<>", (.identifier("<>"), .LESS_GREATER)),
    .string("<", (.identifier("<"), .LESS)),
    .string("<=", (.identifier("<="), .LESS_EQUAL)),
    .string(">", (.identifier(">"), .GREATER)),
    .string(">=", (.identifier(">="), .GREATER_EQUAL)),

    // Punctuation
    .string(".", (.punctuation, .DOT)),
    .string(",", (.punctuation, .COMMA)),
    .string(";", (.punctuation, .SEMICOLON)),
    .string("(", (.punctuation, .L_PAREN)),
    .string(")", (.punctuation, .R_PAREN)),

    // Whitespace
    .regexPattern("\\s", { _ in nil })
])
