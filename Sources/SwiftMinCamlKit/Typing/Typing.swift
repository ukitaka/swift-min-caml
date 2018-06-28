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

typealias Env = [Var: Type]

enum Typing {
    static func type(expr: Expr) -> Expr {
        var env: Env = [:] //TODO: add builtin functions
        //return unify(expr: expr, env: &env)
        fatalError()
    }
    
    private static func mostGeneralUnifier(_ type1: Type, _ type2: Type) -> Substitution {
        switch (type1, type2) {
        case let (.func(args: args1, ret: ret1), .func(args: args2, ret: ret2)):
            let s1: Substitution = zip(args1, args2).map(mostGeneralUnifier).reduce(Substitution(), Substitution.merging)
            let s2 = mostGeneralUnifier(ret1.apply(s1), ret2.apply(s1))
            return s1.merging(other: s2)
        case let (.tuple(elements: elements1), .tuple(elements: elements2)):
            return zip(elements1, elements2).map(mostGeneralUnifier).reduce(Substitution(), Substitution.merging)
        case let (.array(element: element1), .array(element: element2)):
            return mostGeneralUnifier(element1, element2)
        default:
            return Substitution()
        }
    }

    private static func g(expr: Expr, env: Env) -> Type {
        switch expr {
        case .unit:
            return .unit
        case .int:
            return .int
        case .float:
            return .float
        case .bool:
            return .bool
        default:
            fatalError()
        }
            /*
        case let .not(op: op):
            fatalError()
        case let .add(lhs: lhs, rhs: rhs):
            let lhs = unify(expr: lhs, env: &env)
            let rhs = unify(expr: rhs, env: &env)
            return .add(lhs: lhs, rhs: rhs)
        case let .sub(lhs: lhs, rhs: rhs):
            let lhs = unify(expr: lhs, env: &env)
            let rhs = unify(expr: rhs, env: &env)
            return .add(lhs: lhs, rhs: rhs)
        case let .mul(lhs: lhs, rhs: rhs):
            let lhs = unify(expr: lhs, env: &env)
            let rhs = unify(expr: rhs, env: &env)
            return .add(lhs: lhs, rhs: rhs)
        case let .div(lhs: lhs, rhs: rhs):
            let lhs = unify(expr: lhs, env: &env)
            let rhs = unify(expr: rhs, env: &env)
            return .add(lhs: lhs, rhs: rhs)

        case let .`if`(cond, ifTrue, ifFalse):
            let cond = unify(expr: cond, env: &env)
            let ifTrue = unify(expr: ifTrue, env: &env)
            let ifFalse = unify(expr: ifFalse, env: &env)
            return .if(cond: cond,
                       ifTrue: ifTrue,
                       ifFalse: ifFalse)

        case let .`let`(typedVar, bind, body):
            let typedBind = unify(expr: bind, env: &env)
            env[typedVar.name] = typedBind
            let typedBody = unify(expr: body, env: &env)
            env.removeValue(forKey: varName)
            return .let(varName: varName, bind: typedBind, body: typedBody, type: typedBody.type)

        case let .`var`(variable, _):
            guard let type = env[variable] else {
                fatalError("Unknown variable: \(variable)")
            }
            return .var(variable: variable, type: type)

        case .letRec: // let .letRec(name, args, bind, body, type):
            fatalError("Not implemeneted yet")

        case let .apply(function, args, _):
            guard let functionType = env[function]?.asFunc else {
                fatalError("Unknown function: \(function)")
            }
            let typedArgs = args.map { unify(expr: $0, env: &env) }
            precondition(typedArgs.map { $0.type } == functionType.args)
            return .apply(function: function, args: typedArgs, type: functionType.ret)

        case let .tuple(elements, _):
            let typeElements = elements.map { unify(expr: $0, env: &env) }
            return .tuple(elements: typeElements, type: .tuple(elements: typeElements.map { $0.type }))

        case let .readTuple(vars, bindings, body, _):
            let typedBindings = unify(expr: bindings, env: &env)
            precondition(typedBindings.type.isTuple)
            for (v, t) in zip(vars, typedBindings.type.asTuple!) {
                env[v] = t
            }
            let typedBody = unify(expr: body, env: &env)
            for v in vars {
                env.removeValue(forKey: v)
            }
            return .readTuple(vars: vars, bindings: typedBindings, body: typedBody, type: typedBody.type)

        case .createArray: // let .createArray(size, element, type):
            fatalError("Not implemeneted yet")
        case .readArray: // let .readArray(array, index, type):
            fatalError("Not implemeneted yet")
        case .writeArray: // let .writeArray(array, index, value, type):
            fatalError("Not implemeneted yet")
        }
 */
    }
}
