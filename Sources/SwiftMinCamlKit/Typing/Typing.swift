//
//  Typing.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/21.
//

private var counter: Int = 0

extension Type {
    static func newTypeVar() -> Type {
        defer {
            counter += 1
        }
        return .typeVar(name: "TypeVar\(counter)")
    }
}

enum Typing {
    static func type(expr: Expr) -> TypedExpr {
        let constraintType = expr.constraintTyping()
        //FIXME: implement
        return constraintType
    }
    
    static func type(const: Const) -> Type {
        switch const {
        case .bool:
            return .bool
        case .float:
            return .float
        case .integer:
            return .int
        }
    }
}
