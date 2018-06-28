//
//  ParserTests.swift
//  SwiftMinCamlTests
//
//  Created by Yuki Takahashi on 2018/06/12.
//

import XCTest
@testable import SwiftMinCamlKit

class ParserTest: XCTestCase {
    func parse(input: String) -> Expr {
        let parser = Parser()
        try! lexer.tokenize(input) { (t, c) in
            try! parser.consume(token: t, code: c)
        }
        let expr = try! parser.endParsing()
        return expr
    }

    func testConst() {
        // integer
        let integer = self.parse(input: "1")
        XCTAssertEqual(integer.asInt, 1)
        
        let integer2 = self.parse(input: "-10")
        XCTAssertEqual(integer2.asInt, -10)
        
        // double
        let double = self.parse(input: "1.2")
        XCTAssertEqual(double.asFloat, 1.2)
        
        let double2 = self.parse(input: "-3.4")
        XCTAssertEqual(double2.asFloat, -3.4)
        
        // bool
        let bool = self.parse(input: "true")
        XCTAssertEqual(bool.asBool, true)
    }
    
    func testAdd() {
        let input = "1+2"
        let exp = self.parse(input: input).asAdd!
        XCTAssertEqual(exp.lhs, .int(1))
        XCTAssertEqual(exp.rhs, .int(2))
    }
    
    func testVar() {
        let input = "abc"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isVar)
        let v = exp.asVar!
        XCTAssertEqual(v.rawValue, "abc")
    }

    func testApply() {
        let input = "print_int 123"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isApp)
        let a = exp.asApp!
        XCTAssertEqual(a.function.asVar?.rawValue, "print_int")
    }

    func testLet() {
        let input = "let x = 1 in x + 2"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isLet)
        let l = exp.asLet!
        XCTAssertEqual(l.name.name, "x")
        XCTAssertTrue(l.body.isAdd)
    }
    
    func testIf() {
        let input = "if true then 1 else 2"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isIf)
    }
    
    func testLetRec() {
        let input = "let rec f a b = 1 in 2"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isLetRec)
    }
    
    func testTuple() {
        let input = "(1, 2, 3)"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isTuple)
    }
    
    func testReadTuple() {
        let input = "let (x, y, z) = a in x"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isLetTuple)
    }
    
    func testCreateArray() {
        let input = "Array.create 2 1"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isArray)
    }
    
    func testReadArray() {
        let input = "a.(1)"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isGet)
    }
    
    func testWriteArray() {
        let input = "a.(1) <- 2"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isPut)
    }
}
