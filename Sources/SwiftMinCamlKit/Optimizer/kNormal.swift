//
//  kNormal.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/30.
//

extension Optimizer {
    func kNormal(_ env: Env, _ expr: Expr) -> (NormalizedExpr, Type) {
        switch expr {
        case .unit:
            return (.unit, .unit)
        case let .bool(v):
            return v ? (.int(1), .int) : (.int(0), .int)
        case let .int(v):
            return (.int(v), .int)
        case let .float(v):
            return (.float(v), .float)
        case .not(let op):
            return kNormal(env, .if(cond: op, ifTrue: .bool(false), ifFalse: .bool(true)))
        case .neg(let op):
            return insertLet(kNormal(env, op)) { x in (.neg(op: x), .int) }
        case .add(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.add(lhs: x, rhs: y), .int)
                }
            }
        case .sub(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.sub(lhs: x, rhs: y), .int)
                }
            }
        case .mul(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.mul(lhs: x, rhs: y), .int)
                }
            }
        case .div(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.div(lhs: x, rhs: y), .int)
                }
            }
        case .fneg(let op):
            return insertLet(kNormal(env, op)) { x in (.fneg(op: x), .float) }
        case .fadd(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.fadd(lhs: x, rhs: y), .float)
                }
            }
        case .fsub(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.fsub(lhs: x, rhs: y), .float)
                }
            }
        case .fmul(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.fmul(lhs: x, rhs: y), .float)
                }
            }
        case .fdiv(let lhs, let rhs):
            return insertLet(kNormal(env, lhs)) { x in
                insertLet(kNormal(env, rhs)) { y in
                    (.fdiv(lhs: x, rhs: y), .float)
                }
            }
        case .eq, .le:
            return kNormal(env, .if(cond: expr, ifTrue: .bool(true), ifFalse: .bool(false)))
        case .if(.not(let cond), let ifTrue, let ifFalse):
            return kNormal(env, .if(cond: cond, ifTrue: ifFalse, ifFalse: ifTrue))
        case let .if(.eq(lhs: lhs, rhs: rhs), ifTrue, ifFalse):
            return insertLet(kNormal(env, lhs)) { l in
                insertLet(kNormal(env, rhs)) { r in
                    let (ite, itt) = kNormal(env, ifTrue)
                    let (ife, _) = kNormal(env, ifFalse)
                    return (.ifLE(lhs: l, rhs: r, ifTrue: ite, ifFalse: ife), itt)
                }
            }
        case .if(let cond, let ifTrue, let ifFalse):
            return kNormal(env, .if(cond: .eq(lhs: cond, rhs: .bool(false)), ifTrue: ifFalse, ifFalse: ifTrue))
        case .let(let name, let bind, let body):
            let (bie, bit) = kNormal(env, bind)
            var env = env
            env.updateValue(bit, forKey: name.name)
            let (boe, bot) = kNormal(env, body)
            return (.let(name: name, bind: bie, body: boe), bot)
        case .var(let name):
            guard let type = env[name] else {
                fatalError("Unknown variable \(name)")
            }
            return (.var(name: name), type)
        case .letRec(let funcDef, let body):
            var env = env
            env.updateValue(funcDef.name.type, forKey: funcDef.name.name)
            let (boe, bot) = kNormal(env, body)
            for arg in funcDef.args {
                env.updateValue(arg.type, forKey: arg.name)
            }
            let (bie, _) = kNormal(env, funcDef.body)
            return (.letRec(funcDef: NormalizedFuncDef(name: funcDef.name, args: funcDef.args, body: bie), body: boe), bot)
        case .app(let function, let args):
            let (fe, ft) = kNormal(env, function)
            guard let funcType = ft.asFunc else {
                fatalError("\(ft) is not a function type.")
            }
            return insertLet((fe, ft)) { f in
                func bind(xs: [Var]) -> ([Expr]) -> (NormalizedExpr, Type) {
                    return { es in
                        guard let first = es.first else {
                            return (.app(function: f, args: xs), funcType.ret)
                        }
                        var es = es
                        es.removeFirst()
                        return self.insertLet(self.kNormal(env, first)) { x in
                            return bind(xs: xs + [x])(es)
                        }
                    }
                }
                return bind(xs: [])(args)
            }
        case .tuple(let elements):
            func bind(xs: [Var], ts: [Type]) -> (([Expr]) -> (NormalizedExpr, Type)) {
                return { es in
                    guard let first = es.first else {
                        return (.tuple(elements: xs), .tuple(elements: ts))
                    }
                    var es = es
                    es.removeFirst()
                    let (e1, t1) = self.kNormal(env, first)
                    return self.insertLet((e1, t1)) { x in
                        bind(xs: xs + [x], ts: ts + [t1])(es)
                    }
                }
            }
            return bind(xs: [], ts: [])(elements)
        case .letTuple(let vars, let binding, let body):
            return insertLet(kNormal(env, binding)) { bie in
                var env = env
                for v in vars {
                    env.updateValue(v.type, forKey: v.name)
                }
                let (boe, bot) = kNormal(env, body)
                return (.letTuple(vars: vars, binding: bie, body: boe), bot)
            }
        case .array(let size, let element):
            return insertLet(kNormal(env, size)) { s in
                let (ee, et) = kNormal(env, element)
                return insertLet((ee, et)) { e in
                    fatalError("FIXME: Call external function")
                }
            }
        case .get(let array, let index):
            let (ae, at) = kNormal(env, array)
            guard let elt = at.asArray else {
                fatalError("\(ae) is not an array.")
            }
            return insertLet((ae, at)) { x in
                insertLet(kNormal(env, index)) { y in
                    return (.get(array: x, index: y), elt)
                }
            }
        case .put(let array, let index, let value):
            return insertLet(kNormal(env, array)) { arr in
                insertLet(kNormal(env, index)) { ind in
                    insertLet(kNormal(env, value)) { val in
                        (.put(array: arr, index: ind, value: val), .unit)
                    }
                }
            }
        }
    }
            
    private func insertLet(_ e: (expr: NormalizedExpr, type: Type), _ k: (Var) -> (NormalizedExpr, Type)) -> (NormalizedExpr, Type) {
        switch e.expr {
        case let .var(name: name):
            return k(name)
        default:
            let newVar = Var.tmpVar()
            let (body, retType) = k(newVar)
            return (NormalizedExpr.let(name: TypedVar(name: newVar, type: e.type), bind: e.expr, body: body), retType)
        }
        
    }
}
