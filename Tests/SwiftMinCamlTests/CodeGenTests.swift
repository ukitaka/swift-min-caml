//
//  CodeGenTests.swift
//  SwiftMinCamlTests
//
//  Created by Yuki Takahashi on 2018/06/17.
//

import XCTest
@testable import SwiftMinCaml

class CodeGenTest: XCTestCase {
    func testArithOps() {
        let parser = Expr.parser
        let input = "1+2*3"
        let exp = try! parser.run(sourceName: "test", input: input)
        let asm = CodeGen().gen(expr: exp)
        print(asm)
    }
}
