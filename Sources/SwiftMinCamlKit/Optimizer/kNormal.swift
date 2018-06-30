//
//  kNormal.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/30.
//

extension Optimizer {
    func kNormal(env: Env, expr: Expr) -> NormalizedExpr {
        fatalError() //TODO: impl
    }
    
    private func insertLet(_ expr: NormalizedExpr, _ type: Type, _ k: (Var) -> (NormalizedExpr, Type)) -> (NormalizedExpr, Type) {
        switch expr {
        case let .var(name: name):
            return k(name)
        default:
            let newVar = Var.tmpVar()
            let (body, retType) = k(newVar)
            return (NormalizedExpr.let(name: TypedVar(name: newVar, type: type), bind: expr, body: body), retType)
        }
        
    }
}
