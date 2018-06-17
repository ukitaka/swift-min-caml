//
//  Driver.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/17.
//

import Foundation

public struct Driver {
    public init() { }
    
    public func run(input: String) -> String {
        let expr = try! Expr.parser.run(sourceName: "main", input: input)
        let output = CodeGen().gen(expr: expr)
        return output
    }
}
