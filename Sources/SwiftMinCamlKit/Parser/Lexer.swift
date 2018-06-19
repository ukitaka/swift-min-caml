//
//  Lexer.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/19.
//

import Foundation
import CitronKit

typealias Lexer = CitronLexer<(Int, Parser.CitronTokenCode)>

let lexer = Lexer(rules: [
    // Numbers
    .regexPattern("[0-9]+", { str in
        if let number = Int(str) {
            return (number, .INTEGER)
        }
        return nil
    }),
    
    // Operators
    .string("+", (0, .ADD)),
    .string("-", (0, .SUBTRACT)),
    .string("*", (0, .MULTIPLY)),
    .string("/", (0, .DIVIDE)),
    
    // Whitespace
    .regexPattern("\\s", { _ in nil })
])
