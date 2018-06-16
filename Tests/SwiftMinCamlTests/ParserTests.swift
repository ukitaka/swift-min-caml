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
    
    func testArithOps() {
        let parser = Expr.parser
        let input = "1+2*3"
        let exp = try! parser.run(sourceName: "test", input: input)
        XCTAssertTrue(exp.isArithOps)
        let arithOps1 = exp.asArithOps!
        XCTAssertEqual(arithOps1.ops, .add)
        XCTAssertEqual(arithOps1.args.first?.asConst?.asInteger, 1)
        let arithOps2 = arithOps1.args.last!.asArithOps!
        XCTAssertEqual(arithOps2.ops, .mul)
        XCTAssertEqual(arithOps2.args.first?.asConst?.asInteger, 2)
        XCTAssertEqual(arithOps2.args.last?.asConst?.asInteger, 3)
    }
    
    func testVar() {
        let parser = Expr.parser
        let input = "abc"
        let exp = try! parser.run(sourceName: "test", input: input)
        XCTAssertTrue(exp.isVar)
        let v = exp.asVar!
        XCTAssertEqual(v.rawValue, "abc")
    }
}
