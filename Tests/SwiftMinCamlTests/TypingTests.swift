//
//  TypingTests.swift
//  SwiftMinCamlTests
//
//  Created by Yuki Takahashi on 2018/06/21.
//

import XCTest
@testable import SwiftMinCamlKit

class TypingTests: XCTestCase {
    func testType1() {
        let expr = Expr.add(lhs: .int(1),
                            rhs: .add(lhs: .int(2), rhs: .int(3)))
        let (_, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .int)
    }

    func testType2() {
        let expr = Expr.let(name: TypedVar(name: "x"), bind: .int(1), body: .add(lhs: .int(1), rhs: .int(2)))
        let (checkedExpr, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .int)
        XCTAssertEqual(checkedExpr.asLet?.name.type, .int)
    }
    
    func testLetRec() {
        // if n == 0 then true else false
        let body: Expr = Expr.if(
            cond: .eq(lhs: .var(name: "n"), rhs: .int(0)),
            ifTrue: .bool(true),
            ifFalse: .bool(false)
        )
        let funcDef = FuncDef(name: TypedVar(name: "isZero"), args: [TypedVar(name: "n")], body: body)
        let expr = Expr.letRec(funcDef: funcDef, body: .int(1))
        let (checkedExpr, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .int)
        XCTAssertEqual(checkedExpr.asLetRec?.funcDef.args.first?.type, .int)
        XCTAssertEqual(checkedExpr.asLetRec?.funcDef.name.type, Type.func(args: [.int], ret: .bool))
    }
    
    func testCall() {
        // let rec fac n = if n == 0 then 0 else n + (fac n - 1)
        let body: Expr = Expr.if(
            cond: .eq(lhs: .var(name: "n"), rhs: .int(0)),
            ifTrue: .int(0),
            ifFalse: .add(lhs: .var(name: "n"),
                          rhs: .app(function: .var(name: "fac"), args: [ .sub(lhs: .var(name: "n"), rhs: .int(1)) ]))
        )
        let funcType: Type = Type.func(args: TypeVar.newTypeVars(n: 1), ret: TypeVar.newTypeVar())
        let funcDef = FuncDef(name: TypedVar(name: "fac", type: funcType), args: [TypedVar(name: "n")], body: body)
        let expr = Expr.letRec(funcDef: funcDef, body: .app(function: .var(name: "fac"), args: [.int(8)]))
        print(expr)
        let (checkedExpr, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .int)
        XCTAssertEqual(checkedExpr.asLetRec?.funcDef.args.first?.type, .int)
        XCTAssertEqual(checkedExpr.asLetRec?.funcDef.name.type, Type.func(args: [.int], ret: .int))
    }
    
    func testTuple() {
        let tuple = Expr.tuple(elements: [.int(1), .bool(true), .float(4.2)])
        let (_, type) = Typing.type(expr: tuple)
        XCTAssertEqual(type, .tuple(elements: [.int, .bool, .float]))
    }
    
    func testLetTuple() {
        let expr = Expr.letTuple(vars: [TypedVar(name: "a"), TypedVar(name: "b"), TypedVar(name: "c")],
                                 binding: Expr.tuple(elements: [.int(1), .bool(true), .float(4.2)]),
                                 body: Expr.var(name: "a"))
        let (typedExpr, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .int)
        XCTAssertEqual(typedExpr.asLetTuple?.vars.first?.type, .int)
        XCTAssertEqual(typedExpr.asLetTuple?.vars.last?.type, .float)
    }
    
    func testArray() {
        let expr = Expr.array(size: .int(10), element: .int(0))
        let (_, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .array(element: .int))
    }
    
    func testGet() {
        let arr = Expr.array(size: .int(10), element: .int(0))
        let expr = Expr.get(array: arr, index: .int(4))
        let (_, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .int)
    }
    
    func testPut() {
        let arr = Expr.array(size: .int(10), element: .int(0))
        let expr = Expr.put(array: arr, index: .int(4), value: .int(5))
        let (_, type) = Typing.type(expr: expr)
        XCTAssertEqual(type, .unit)
    }
}
