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
        
        let integer2 = try! parser.run(sourceName: "test", input: "-10")
        XCTAssertEqual(integer2.asConst?.asInteger ?? 0, -10)
        
        // double
        let double = try! parser.run(sourceName: "test", input: "1.2")
        XCTAssertEqual(double.asConst?.asFloat ?? 0.0, 1.2)
        
        let double2 = try! parser.run(sourceName: "test", input: "-3.4")
        XCTAssertEqual(double2.asConst?.asFloat ?? 0.0, -3.4)
        
        // bool
        let bool = try! parser.run(sourceName: "test", input: "true")
        XCTAssertEqual(bool.asConst?.asBool ?? false, true)
    }
}
