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
        let exp = Expr.arithOps(ops: .add, args: [
            .const(const: .integer(1)),
            .arithOps(ops: .mul, args: [
                .const(const: .integer(2)),
                .const(const: .integer(3))
                ])
            ])
        print(exp.constraintTyping())
    }
}
