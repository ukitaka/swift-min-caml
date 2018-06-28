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
    static func type(env: Env, expr: inout Expr) -> Type {
        return typeInfer(env: env, expr: &expr)
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
        case (.unit, .unit), (.bool, .bool), (.int, .int), (.float, .float):
            return Substitution()
        case (.typeVar, _):
            if type1 == type2 {
                return Substitution()
            } else {
                return Substitution([type1:type2])
            }
        case (_, .typeVar):
            if type1 == type2 {
                return Substitution()
            } else {
                return Substitution([type2:type1])
            }
        default:
            fatalError("Cannot find most general unifier. type1: \(type1), type2: \(type2)")
        }
    }
    
    @discardableResult
    private static func unify(env: Env, expr: inout Expr, type: Type) -> Type {
        let t = typeInfer(env: env, expr: &expr)
        let s = mostGeneralUnifier(type, t)
        return t.apply(s)
    }
    
    @discardableResult
    private static func unify(env: Env, lhs: inout Expr, rhs: inout Expr) -> Type {
        let l = typeInfer(env: env, expr: &lhs)
        let r = typeInfer(env: env, expr: &rhs)
        let s = mostGeneralUnifier(l, r)
        return l.apply(s) // or r.apply(s)
    }

    private static func typeInfer(env: Env, expr: inout Expr) -> Type {
        switch expr {
        case .unit:
            return .unit
        case .bool:
            return .bool
        case .int:
            return .int
        case .float:
            return .float
        case var .not(op: op):
            return unify(env: env, expr: &op, type: .bool)
        case var .neg(op: op):
            return unify(env: env, expr: &op, type: .int)
        case var .add(lhs: lhs, rhs: rhs):
            unify(env: env, expr: &lhs, type: .int)
            unify(env: env, expr: &rhs, type: .int)
            return .int
        case var .sub(lhs: lhs, rhs: rhs):
            unify(env: env, expr: &lhs, type: .int)
            unify(env: env, expr: &rhs, type: .int)
            return .int
        case var .fneg(op: op):
            return unify(env: env, expr: &op, type: .float)
        case var .fadd(lhs: lhs, rhs: rhs):
            unify(env: env, expr: &lhs, type: .float)
            unify(env: env, expr: &rhs, type: .float)
            return .float
        case var .fsub(lhs: lhs, rhs: rhs):
            unify(env: env, expr: &lhs, type: .float)
            unify(env: env, expr: &rhs, type: .float)
            return .float
        case var .fmul(lhs: lhs, rhs: rhs):
            unify(env: env, expr: &lhs, type: .float)
            unify(env: env, expr: &rhs, type: .float)
            return .float
        case var .fdiv(lhs: lhs, rhs: rhs):
            unify(env: env, expr: &lhs, type: .float)
            unify(env: env, expr: &rhs, type: .float)
            return .float
        case var .eq(lhs: lhs, rhs: rhs):
             unify(env: env, lhs: &lhs, rhs: &rhs)
            return .bool
        case var .le(lhs: lhs, rhs: rhs): //MEMO: need to check lhs/rhs are both number.
            unify(env: env, lhs: &lhs, rhs: &rhs)
            return .bool
        case var .if(cond, ifTrue, ifFalse):
            unify(env: env, expr: &cond, type: .bool)
            return unify(env: env, lhs: &ifTrue, rhs: &ifFalse)
        case .let(let name, var bind, var body):
            let bindType = unify(env: env, expr: &bind, type: name.type)
            var env = env
            env.updateValue(bindType, forKey: name.name)
            let bodyType = typeInfer(env: env, expr: &body)
            // update expr
            expr = .let(name: name.assign(type: bindType), bind: bind, body: body)
            return bodyType
        default:
            fatalError()
        }
            /*

        case var .`let`(typedVar, bind, body):
            let typedBind = unify(expr: bind, env: &env)
            env[typedVar.name] = typedBind
            let typedBody = unify(expr: body, env: &env)
            env.removeValue(forKey: varName)
            return .let(varName: varName, bind: typedBind, body: typedBody, type: typedBody.type)

        case var .`var`(variable, _):
            guard let type = env[variable] else {
                fatalError("Unknown variable: \(variable)")
            }
            return .var(variable: variable, type: type)

        case .letRec: // let .letRec(name, args, bind, body, type):
            fatalError("Not implemeneted yet")

        case var .apply(function, args, _):
            guard let functionType = env[function]?.asFunc else {
                fatalError("Unknown function: \(function)")
            }
            let typedArgs = args.map { unify(expr: $0, env: &env) }
            precondition(typedArgs.map { $0.type } == functionType.args)
            return .apply(function: function, args: typedArgs, type: functionType.ret)

        case var .tuple(elements, _):
            let typeElements = elements.map { unify(expr: $0, env: &env) }
            return .tuple(elements: typeElements, type: .tuple(elements: typeElements.map { $0.type }))

        case var .readTuple(vars, bindings, body, _):
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
