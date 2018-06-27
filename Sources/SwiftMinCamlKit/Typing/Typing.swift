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

typealias Context = [Var: Type]

enum Typing {
    static func type(expr: Expr) -> TypedExpr {
        let constraintType = expr.constraintTyping()
        var context: Context = [:] //TODO: add builtin functions
        return unify(typedExpr: constraintType, context: &context)
    }
    
    private static func unify(typedExpr: TypedExpr, context: inout Context) -> TypedExpr {
        precondition(typedExpr.type.isTypeVar)
        switch typedExpr {
        case let .const(const, _):
            return .const(const: const, type: typed(const: const))
        case let .arithOps(ops, args, _):
            let lhs = unify(typedExpr: args.first!, context: &context)
            let rhs = unify(typedExpr: args.last!, context: &context)
            precondition(lhs.type == rhs.type)
            return .arithOps(ops: ops,
                             args: [lhs, rhs],
                             type: lhs.type)
        case let .`if`(cond, ifTrue, ifFalse, _):
            let typedCond = unify(typedExpr: cond, context: &context)
            let typedIfTrue = unify(typedExpr: ifTrue, context: &context)
            let typedIfFalse = unify(typedExpr: ifFalse, context: &context)
            precondition(typedCond.type == .bool)
            precondition(typedIfTrue.type == typedIfFalse.type)
            return .if(cond: typedCond,
                       ifTrue: typedIfTrue,
                       ifFalse: typedIfFalse,
                       type: typedIfTrue.type)
        case let .`let`(varName, bind, body, _):
            let typedBind = unify(typedExpr: bind, context: &context)
            context[varName] = typedBind.type
            let typedBody = unify(typedExpr: body, context: &context)
            return .let(varName: varName, bind: typedBind, body: typedBody, type: typedBody.type)
        case let .`var`(variable, _):
            guard let type = context[variable] else {
                fatalError("Unknown variable: \(variable)")
            }
            return .var(variable: variable, type: type)
        case .letRec: // let .letRec(name, args, bind, body, type):
            fatalError("Not implemeneted yet")
        case let .apply(function, args, _):
            guard let functionType = context[function]?.asFunc else {
                fatalError("Unknown function: \(function)")
            }
            let typedArgs = args.map { unify(typedExpr: $0, context: &context) }
            precondition(typedArgs.map{ $0.type } == functionType.args)
            return .apply(function: function, args: args, type: functionType.ret)
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
