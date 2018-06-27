//
//  TypingTests.swift
//  SwiftMinCamlTests
//
//  Created by Yuki Takahashi on 2018/06/21.
//

import XCTest
@testable import SwiftMinCamlKit

class TypingTests: XCTestCase {
    func testConstraintTyping() {
        let expr = Expr.arithOps(ops: .add, args: [
            .const(const: .integer(1)),
            .arithOps(ops: .mul, args: [
                .const(const: .integer(2)),
                .const(const: .integer(3))
                ])
            ])
        let typedExpr = Typing.type(expr: expr)
        XCTAssertEqual(typedExpr.type, .int)
    }
}
