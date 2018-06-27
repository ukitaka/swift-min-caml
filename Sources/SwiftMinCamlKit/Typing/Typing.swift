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
        return unify(typedExpr: constraintType)
    }
    
    private static func unify(typedExpr: TypedExpr) -> TypedExpr {
        switch typedExpr {
        case let .const(const, type):
            precondition(type.isTypeVar)
            return .const(const: const, type: typed(const: const))
        case let .arithOps(ops, args, type):
            guard type.isTypeVar else { return typedExpr }
            let lhs = unify(typedExpr: args.first!)
            let rhs = unify(typedExpr: args.last!)
            let concreteType = unify(lhs: lhs.type, rhs: rhs.type)
            return .arithOps(ops: ops,
                             args: [lhs.typed(type: concreteType), rhs.typed(type: concreteType)],
                             type: concreteType)
        case let .`if`(cond, ifTrue, ifFalse, type):
            guard type.isTypeVar else { return typedExpr }
            let c = unify(typedExpr: cond)
            let t = unify(typedExpr: ifTrue)
            let f = unify(typedExpr: ifFalse)
            let concreteType = unify(lhs: t.type, rhs: f.type)
            return .if(cond: c.typed(type: .bool),
                       ifTrue: t.typed(type: concreteType),
                       ifFalse: f.typed(type: concreteType),
                       type: concreteType)
        case let .`let`(varName, bind, body, type):
            fatalError()
        case let .`var`(variable, type):
            fatalError()
        case let .letRec(name, args, bind, body, type):
            fatalError()
        case let .apply(function, args, type):
            fatalError()
        case let .tuple(elements, type):
            fatalError()
        case let .readTuple(vars, bindings, body, type):
            fatalError()
        case let .createArray(size, element, type):
            fatalError()
        case let .readArray(array, index, type):
            fatalError()
        case let .writeArray(array, index, value, type):
            fatalError()
        }
    }
    
    private static func unify(lhs: Type, rhs: Type) -> Type {
        switch (lhs, rhs) {
        case (.int, .int):
            return .int
        case (.int, .typeVar):
            return .int
        case (.typeVar, .int):
            return .int
        case (.float, .float):
            return .float
        case (.float, .typeVar):
            return .float
        case (.typeVar, .float):
            return .float
        case (.bool, .typeVar):
            return .bool
        case (.typeVar, .bool):
            return .bool
        case (.bool, .bool):
            return .bool
        default:
            fatalError("cannot unify")
        }
    }
    
    static func typed(const: Const) -> Type {
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
