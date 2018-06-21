//
//  Typing.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/21.
//

class Typing {
    private var counter: Int = 0
}

extension Typing {
    func newTypeVar() -> Type {
        defer {
            counter += 1
        }
        return .typeVar(name: "TypeVar\(counter)")
    }
    
    func constraintTyping(expr: Expr) -> TypedExpr {
        fatalError("TODO")
    }
}
