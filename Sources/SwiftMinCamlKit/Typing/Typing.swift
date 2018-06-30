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
        case (.typeVar, .typeVar):
            // MinCaml spec. Type system infers type variable as integer when
            // typing is too complex.
            return Substitution([type1: .int, type2: .int])
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

    private static func typeInfer(env: Env, lhs: Expr, rhs: Expr, returnType: Type) -> (Substitution, Type) {
        let (ls, lt) = typeInfer(env: env, expr: lhs)
        let (rs, rt) = typeInfer(env: env, expr: rhs)
        let s = mostGeneralUnifier(lt, rt).merging(other: ls).merging(other: rs)
        precondition(lt.apply(s) == rt.apply(s))
        return (s, returnType)
    }

    private static func typeInfer(env: Env, expr: Expr) -> (Substitution, Type) {
        switch expr {
        case .unit: return (Substitution(), .unit)
        case .bool: return (Substitution(), .bool)
        case .int: return (Substitution(), .int)
        case .float: return (Substitution(), .float)
        case let .not(op: op):
            return typeInfer(env: env, expr: op, preferredType: .bool)
        case let .neg(op: op):
            return typeInfer(env: env, expr: op, preferredType: .int)
        case let .fneg(op: op):
            return typeInfer(env: env, expr: op, preferredType: .float)
        case let .add(lhs: lhs, rhs: rhs),
             let .sub(lhs: lhs, rhs: rhs),
             let .mul(lhs: lhs, rhs: rhs),
             let .div(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .fadd(lhs: lhs, rhs: rhs),
            let .fsub(lhs: lhs, rhs: rhs),
            let .fmul(lhs: lhs, rhs: rhs),
            let .fdiv(lhs: lhs, rhs: rhs):
            return typeInfer(env: env, lhs: lhs, rhs: rhs, preferredType: .int)
        case let .eq(lhs: lhs, rhs: rhs),
             let .le(lhs: lhs, rhs: rhs): //MEMO: need to check lhs/rhs are both number.
            return typeInfer(env: env, lhs: lhs, rhs: rhs, returnType: .bool)
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
        case let .letRec(funcDef: funcDef, body: body):
            var funcDef = funcDef
            var env1 = env
            env1.updateValue(funcDef.name.type, forKey: funcDef.name.name)
            for arg in funcDef.args {
                env1.updateValue(arg.type, forKey: arg.name)
            }
            let (s0, retType) = typeInfer(env: env1, expr: funcDef.body)
            funcDef = funcDef.apply(s0)
            let argTypes = funcDef.args.map { $0.type }
            let funcType = Type.func(args: argTypes, ret: retType)
            let s1 = mostGeneralUnifier(funcDef.name.type,  funcType).merging(other: s0)
            var env2 = env
            env2.updateValue(funcType.apply(s1), forKey: funcDef.name.name)
            let (bos, bot) = typeInfer(env: env2, expr: body.apply(s1))
            let s2 = s1.merging(other: bos)
            return (s2, bot.apply(s2))
        case let .app(function: function, args: args):
            let (s1, f) = typeInfer(env: env, expr: function)
            guard let funcType = f.asFunc else {
                fatalError("\(f) is not a function type.")
            }
            let a = args.map { arg in typeInfer(env: env, expr: arg) }
            let s2 = a.map { $0.0 }.reduce(Substitution(), Substitution.merging)
            let types = a.map { $0.1 }
            
            let s3 = zip(funcType.args, types)
                .map(mostGeneralUnifier)
                .reduce(Substitution(), Substitution.merging)
            return (s1.merging(other: s2).merging(other: s3), funcType.ret)
        case let .tuple(elements):
            let results = elements.map { arg in typeInfer(env: env, expr: arg) }
            let s = results.map { $0.0 }.reduce(Substitution(), Substitution.merging)
            let type = Type.tuple(elements: results.map { $0.1 }).apply(s)
            return (s, type)
        case let .letTuple(vars, bind, body):
            let (bis, bit) = typeInfer(env: env, expr: bind)
            var env = env
            var varsSub = Substitution()
            guard let tupleType = bit.apply(bis).asTuple, vars.count == tupleType.count else {
                fatalError("\(bind) is not a tuple type.")
            }
            for (v, t) in zip(vars, tupleType)  {
                precondition(!t.isTypeVar, "\(t) is a type variable.")
                env.updateValue(t, forKey: v.name)
                varsSub = varsSub.merging(other: Substitution([v.type: t]))
            }
            let (bos, bot) = typeInfer(env: env, expr: body)
            let s = bis.merging(other: bos).merging(other: varsSub)
            return (s, bot.apply(s))
        case let .array(size, element):
            let (s1, _) = typeInfer(env: env, expr: size, preferredType: .int)
            let (s2, t2) = typeInfer(env: env, expr: element)
            return (s1.merging(other: s2), .array(element: t2))
        case .get:
            fatalError("not implemented yet")
        case .put:
            fatalError("not implemented yet")
        }
    }
}
