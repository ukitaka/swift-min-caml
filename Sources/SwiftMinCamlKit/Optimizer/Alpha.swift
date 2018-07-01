//
//  Alpha.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/07/01.
//

extension Optimizer {
    private static func find(_ x: Var, _ env: [Var: Var]) -> Var {
        return env[x] ?? x
    }

    static func alpha(_ env: [Var: Var], _ expr: NormalizedExpr) -> NormalizedExpr {
        switch expr {
        case .unit, .int, .float:
            return expr
        case .neg(let op):
            return .neg(op: find(op, env))
        case .add(let lhs, let rhs):
            return .add(lhs: find(lhs, env), rhs: find(rhs, env))
        case .sub(let lhs, let rhs):
            return .sub(lhs: find(lhs, env), rhs: find(rhs, env))
        case .mul(let lhs, let rhs):
            return .mul(lhs: find(lhs, env), rhs: find(rhs, env))
        case .div(let lhs, let rhs):
            return .div(lhs: find(lhs, env), rhs: find(rhs, env))
        case .fneg(let op):
            return .fneg(op: find(op, env))
        case .fadd(let lhs, let rhs):
            return .fadd(lhs: find(lhs, env), rhs: find(rhs, env))
        case .fsub(let lhs, let rhs):
            return .fsub(lhs: find(lhs, env), rhs: find(rhs, env))
        case .fmul(let lhs, let rhs):
            return .fmul(lhs: find(lhs, env), rhs: find(rhs, env))
        case .fdiv(let lhs, let rhs):
            return .fdiv(lhs: find(lhs, env), rhs: find(rhs, env))
        case .ifEq(let lhs, let rhs, let ifTrue, let ifFalse):
            return .ifEq(lhs: find(lhs, env), rhs: find(rhs, env), ifTrue: alpha(env, ifTrue), ifFalse: alpha(env, ifFalse))
        case .ifLE(let lhs, let rhs, let ifTrue, let ifFalse):
            return .ifLE(lhs: find(lhs, env), rhs: find(rhs, env), ifTrue: alpha(env, ifTrue), ifFalse: alpha(env, ifFalse))
        case .let(let name, let bind, let body):
            let newName = Var.tmpVar()
            var bodyEnv = env
            bodyEnv.updateValue(newName, forKey: name.name)
            return .let(name: TypedVar(name: newName, type: name.type), bind: alpha(env, bind), body: alpha(bodyEnv, body))
        case .var(let name):
            fatalError("Not implemented yet")
        case .letRec(let funcDef, let body):
            fatalError("Not implemented yet")
        case .app(let function, let args):
            fatalError("Not implemented yet")
        case .tuple(let elements):
            fatalError("Not implemented yet")
        case .letTuple(let vars, let binding, let body):
            fatalError("Not implemented yet")
        case .array(let size, let element):
            fatalError("Not implemented yet")
        case .get(let array, let index):
            fatalError("Not implemented yet")
        case .put(let array, let index, let value):
            fatalError("Not implemented yet")
        case .extArray(let elements):
            fatalError("Not implemented yet")
        case .extFunApp(let function, let args):
            fatalError("Not implemented yet")
        }
    }
    
}
