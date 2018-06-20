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
        XCTAssertEqual(integer.asConst?.asInteger ?? 0, 1)
        
        let integer2 = self.parse(input: "-10")
        XCTAssertEqual(integer2.asConst?.asInteger ?? 0, -10)
        
        // double
        let double = self.parse(input: "1.2")
        XCTAssertEqual(double.asConst?.asFloat ?? 0.0, 1.2)
        
        let double2 = self.parse(input: "-3.4")
        XCTAssertEqual(double2.asConst?.asFloat ?? 0.0, -3.4)
        
        // bool
        let bool = self.parse(input: "true")
        XCTAssertEqual(bool.asConst?.asBool ?? false, true)
    }
    
    func testArithOps() {
        let input = "1+2*3"
        let exp = self.parse(input: input)
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
        let input = "abc"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isVar)
        let v = exp.asVar!
        XCTAssertEqual(v.rawValue, "abc")
    }

    func testApply() {
        let input = "print_int 123"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isApply)
        let a = exp.asApply!
        XCTAssertEqual(a.function.rawValue, "print_int")
    }

    func testLet() {
        let input = "let x = 1 in x + 2"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isLet)
        let l = exp.asLet!
        XCTAssertEqual(l.varName, "x")
        XCTAssertTrue(l.body.isArithOps)
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
        XCTAssertTrue(exp.isReadTuple)
    }
    
    func testCreateArray() {
        let input = "Array.create 2 1"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isCreateArray)
    }
    
    func testReadArray() {
        let input = "a.(1)"
        let exp = self.parse(input: input)
        XCTAssertTrue(exp.isReadArray)
    }
}
