//
//  Typing.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/21.
//

typealias Env = [Var: Type]

enum Typing {
    static func type(env: Env, expr: Expr) -> (Expr, Type) {
        let (substitution, type) = typeInfer(env: env, expr: expr)
        return (expr.apply(substitution), type.apply(substitution))
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
    
    private static func typeInfer(env: Env, expr: Expr, preferredType: Type) -> (Substitution, Type) {
        let (subsutitution, inferredType) = typeInfer(env: env, expr: expr)
        let s = subsutitution.merging(other: mostGeneralUnifier(preferredType, inferredType.apply(subsutitution)))
        return (s, inferredType.apply(s))
    }
    
    private static func typeInfer(env: Env, lhs: Expr, rhs: Expr, preferredType: Type) -> (Substitution, Type) {
        let (ls, lt) = typeInfer(env: env, expr: lhs, preferredType: preferredType)
        let (rs, rt) = typeInfer(env: env, expr: rhs, preferredType: preferredType)
        let s = mostGeneralUnifier(lt, rt).merging(other: ls).merging(other: rs)
        precondition(lt.apply(s) == rt.apply(s) && rt.apply(s) == preferredType)
        return (s, lt.apply(s))
    }

    private static func typeInfer(env: Env, lhs: Expr, rhs: Expr) -> (Substitution, Type) {
        let (ls, lt) = typeInfer(env: env, expr: lhs)
        let (rs, rt) = typeInfer(env: env, expr: rhs)
        let s = mostGeneralUnifier(lt, rt).merging(other: ls).merging(other: rs)
        precondition(lt.apply(s) == rt.apply(s))
        return (s, lt.apply(s))
    }

    private static func typeInfer(env: Env, expr: Expr) -> (Substitution, Type) {
        switch expr {
        case .unit:
            return (Substitution(), .unit)
        case .bool:
            return (Substitution(), .bool)
        case .int:
            return (Substitution(), .int)
        case .float:
            return (Substitution(), .float)
        case let .not(op: op):
            return typeInfer(env: env, expr: op, preferredType: .bool)
        case let .neg(op: op):
            return typeInfer(env: env, expr: op, preferredType: .int)
        case let .add(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .sub(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .fneg(op: op):
            return typeInfer(env: env, expr: op, preferredType: .int)
        case let .fadd(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .fsub(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .fmul(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .fdiv(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .eq(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs)
        case let .le(lhs: lhs, rhs: rhs): //MEMO: need to check lhs/rhs are both number.
            return typeInfer(env: env, lhs: lhs, rhs: rhs)
        case let .if(cond, ifTrue, ifFalse):
            let (s1, _) = typeInfer(env: env, expr: cond, preferredType: .bool)
            let (s2, t2) = typeInfer(env: env, lhs: ifTrue, rhs: ifFalse)
            let s = s1.merging(other: s2)
            return (s, t2.apply(s))
        case let .let(name, bind, body):
            let (bis, bit) = typeInfer(env: env, expr: bind)
            var env = env
            env.updateValue(bit, forKey: name.name)
            let (bos, bot) = typeInfer(env: env, expr: body)
            let s = bis.merging(other: bos).merging(other: Substitution([name.type: bit]))
            return (s, bot.apply(s))
        case let .var(name: name):
            guard let type = env[name] else {
                fatalError("Uknown value: \(name)")
            }
            return (Substitution(), type)
        case .letRec: // .letRec(funcDef: funcDef, body: body):
            fatalError("not implemented yet")
        case .app: // var .app(function: function, args: args):
            fatalError("not implemented yet")
        case .tuple:
            fatalError("not implemented yet")
        case .letTuple:
            fatalError("not implemented yet")
        case .array:
            fatalError("not implemented yet")
        case .get:
            fatalError("not implemented yet")
        case .put:
            fatalError("not implemented yet")
        }
    }
}
