//
//  Alpha.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/07/01.
//

extension Optimizer {
    static func alpha(_ env: [Var: Var], _ expr: NormalizedExpr) -> NormalizedExpr {
        switch expr {
        case .unit, .int, .float:
            return expr
        case .neg(let op):
            return .neg(op: env.find(op))
        case .add(let lhs, let rhs):
            return .add(lhs: env.find(lhs), rhs: env.find(rhs))
        case .sub(let lhs, let rhs):
            return .sub(lhs: env.find(lhs), rhs: env.find(rhs))
        case .mul(let lhs, let rhs):
            return .mul(lhs: env.find(lhs), rhs: env.find(rhs))
        case .div(let lhs, let rhs):
            return .div(lhs: env.find(lhs), rhs: env.find(rhs))
        case .fneg(let op):
            return .fneg(op: find(op, env))
        case .fadd(let lhs, let rhs):
            return .fadd(lhs: env.find(lhs), rhs: env.find(rhs))
        case .fsub(let lhs, let rhs):
            return .fsub(lhs: env.find(lhs), rhs: env.find(rhs))
        case .fmul(let lhs, let rhs):
            return .fmul(lhs: env.find(lhs), rhs: env.find(rhs))
        case .fdiv(let lhs, let rhs):
            return .fdiv(lhs: env.find(lhs), rhs: env.find(rhs))
        case .ifEq(let lhs, let rhs, let ifTrue, let ifFalse):
            return .ifEq(lhs: env.find(lhs), rhs: env.find(rhs), ifTrue: alpha(env, ifTrue), ifFalse: alpha(env, ifFalse))
        case .ifLE(let lhs, let rhs, let ifTrue, let ifFalse):
            return .ifLE(lhs: env.find(lhs), rhs: env.find(rhs), ifTrue: alpha(env, ifTrue), ifFalse: alpha(env, ifFalse))
        case .let(let name, let bind, let body):
            let newName = Var.tmpVar()
            return .let(name: TypedVar(name: newName, type: name.type),
                        bind: alpha(env, bind),
                        body: alpha(env.adding(key: newName, value: name.name), body))
        case .var(let name):
            return .var(name: env.find(name))
        case .letRec(let funcDef, let body):
            let env = env.adding(key: funcDef.name.name, value: Var.tmpVar())
            let bodyEnv = env.adding(funcDef.args.map { ($0.name, Var.tmpVar()) })
            let newFuncDef = NormalizedFuncDef(
                name: funcDef.name.alpha(env: env),
                args: funcDef.args.map { arg in arg.alpha(env: bodyEnv) },
                body: alpha(bodyEnv, funcDef.body))
            return .letRec(funcDef: newFuncDef , body: alpha(env, body))
        case .app(let function, let args):
            return .app(function: find(function, env), args: args.map { find($0, env) })
        case .tuple(let elements):
            return .tuple(elements: elements.map { find($0, env) })
        case .letTuple(let vars, let binding, let body):
            let names = vars.map { $0.name }
            let env2 = env.adding(names.map { ($0, Var.tmpVar()) })
            return .letTuple(vars: vars.map { $0.with(newName: env2.find($0.name)) },
                             binding: env.find(binding),
                             body: alpha(env2, body))
        case .array(let size, let element):
            return .array(size: find(size, env), element: find(element, env))
        case .get(let array, let index):
            return .get(array: find(array, env), index: find(index, env))
        case .put(let array, let index, let value):
            return .put(array: find(array, env), index: find(index, env), value: find(value, env))
        case .extArray: // .extArray(let elements):
            fatalError("Not implemented yet")
        case .extFunApp: // .extFunApp(let function, let args):
            fatalError("Not implemented yet")
        }
    }
    
}

private extension Dictionary where Key == Var, Value == Var {
    func find(_ x: Var) -> Var {
        return self[x] ?? x
    }
}

private func find(_ x: Var, _ env: [Var: Var]) -> Var {
    return env[x] ?? x
}

private extension TypedVar {
    func with(newName: Var) -> TypedVar {
        return TypedVar(name: newName, type: self.type)
    }
    
    func alpha(env: [Var: Var]) -> TypedVar {
        return TypedVar(name: env.find(self.name), type: self.type)
    }
}
