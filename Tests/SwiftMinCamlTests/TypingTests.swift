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
        var expr = Expr.add(lhs: .int(1),
                            rhs: .add(lhs: .int(2), rhs: .int(3))
            )
        let type = Typing.type(env: [:], expr: &expr)
        XCTAssertEqual(type, .int)
    }

    func testType2() {
        var expr = Expr.let(name: TypedVar(name: "x"), bind: .int(1), body: .add(lhs: .int(1), rhs: .int(2)))
        let type = Typing.type(env: [:], expr: &expr)
        XCTAssertEqual(type, .int)
        XCTAssertEqual(expr.asLet?.name.type, .int)
    }
}
