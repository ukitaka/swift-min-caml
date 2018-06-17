//
//  AST.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import Tagged

public protocol Node: AutoEquatable, AutoHashable, AutoEnum { }

/// Constants
public enum Const: Node {
    case integer(Int)
    case float(Double)
    case bool(Bool)
}

/// ArithmeticOperations
public enum ArithOps: AutoEnum {
    case add // +
    case sub // -
    case mul // *
    case div // /
}

/// Var
public enum VarTag {}

public typealias Var = Tagged<VarTag, String>

public extension Tagged where Tag == VarTag, RawValue == String {
    static func fromString(_ str: String) -> Var {
        return Var(stringLiteral: str)
    }
}

/// Expressions
public indirect enum Expr: Node {
    case const(const: Const)
    case arithOps(ops: ArithOps, args: [Expr])
    case `if`(cond: Expr, ifTrue:Expr, ifFalse:Expr)
    case `let`(varName: Var, bind: Expr, body: Expr)
    case `var`(variable: Var)
    case letRec(name: Var, args: [Var], bind: Expr, body: Expr)
    case apply(function: Expr, args: [Expr])
    case tuple(elements: [Expr])
    case readTuple(vars: [Var], bindings: Expr, body: Expr)
    case createArray(size: Expr, element: Expr)
    case readArray(array: Expr, index: Expr)
    case writeArray(array: Expr, index: Expr, value: Expr)
}

// Type
public indirect enum Type: Node {
    // primitives
    case int
    case float
    case bool
    
    case `func`(args: [Type], ret: Type)
    case tuple(elements: [Type])
    case array(element: Type)
}
