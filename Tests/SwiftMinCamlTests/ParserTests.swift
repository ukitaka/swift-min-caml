//
//  ParserTests.swift
//  SwiftMinCamlTests
//
//  Created by Yuki Takahashi on 2018/06/12.
//

import XCTest
@testable import SwiftMinCaml

class ParserTest: XCTestCase {
    func testArithmeticOperations() {
        let parser = Expr.parser
        let expr = try! parser.run(sourceName: "test", input: "1")
        XCTAssertTrue(expr.isConst)
        print(expr)
    }
}
