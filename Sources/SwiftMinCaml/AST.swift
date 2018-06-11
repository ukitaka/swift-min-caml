//
//  AST.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import Tagged

protocol Node: AutoEquatable, AutoHashable { }

/// Constants
enum Const: Node {
    case integer(Int)
    case float(Float)
    case bool(Bool)
}

/// ArithmeticOperations
enum ArithOps {
    case add // +
    case sub // -
    case mul // *
    case div // /
}

/// Var
enum VarTag {}

typealias Var = Tagged<VarTag, String>

/// Expressions
indirect enum Expr: Node {
    case const(Const)
    case arithOps(ArithOps, [Expr])
    case `if`(Expr, Expr, Expr)
    case `let`(Var, Expr, Expr)
    case `var`(Var)
    case letRec(Var, [Var], Expr, Expr)
    case apply(Expr, [Expr])
    case tuple([Expr])
    case readTuple([Var], Expr, Expr)
    case createArray(Expr, Expr)
    case readArray(Expr, Expr)
    case writeArray(Expr, Expr, Expr)
}

// Type
indirect enum Type: Node {
    // primitives
    case int
    case float
    case bool
    
    case `func`([Type], Type)
    case tuple([Type])
    case array(Type)
}
