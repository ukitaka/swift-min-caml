//
//  ParserTests.swift
//  SwiftMinCamlTests
//
//  Created by Yuki Takahashi on 2018/06/12.
//

import XCTest
@testable import SwiftMinCaml

class ParserTest: XCTestCase {
    func testConst() {
        let parser = Expr.parser

        // integer
        let integer = try! parser.run(sourceName: "test", input: "1")
        XCTAssertEqual(integer.asConst?.asInteger ?? 0, 1)
        
        // double
        let double = try! parser.run(sourceName: "test", input: "1.2")
        XCTAssertEqual(double.asConst?.asFloat ?? 0.0, 1.2)
        
        // bool
        let bool = try! parser.run(sourceName: "test", input: "true")
        XCTAssertEqual(bool.asConst?.asBool ?? false, true)
    }
}
