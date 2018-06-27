//
//  AST.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import Tagged

/// Var
public enum IDTag {}

public typealias ID = Tagged<IDTag, String>
public typealias Var = ID

public extension Tagged where Tag == IDTag, RawValue == String {
    static func fromString(_ str: String) -> ID {
        return Var(stringLiteral: str)
    }
}

/// Expressions
public indirect enum Expr: AutoTyped, AutoHashable, AutoEquatable {
    case unit
    case bool(Bool)
    case int(Int)
    case float(Double)
    case not(op: Expr)              // !
    case neg(op: Expr)              // unary -
    case add(lhs: Expr, rhs: Expr)  // +
    case sub(lhs: Expr, rhs: Expr)  // -
    case mul(lhs: Expr, rhs: Expr)  // *
    case div(lhs: Expr, rhs: Expr)  // /
    case fadd(lhs: Expr, rhs: Expr) // +
    case fsub(lhs: Expr, rhs: Expr) // -
    case fmul(lhs: Expr, rhs: Expr) // *
    case fdiv(lhs: Expr, rhs: Expr) // /
    case eq(lhs: Expr, rhs: Expr)   // ==
    case le(lhs: Expr, rhs: Expr)   // <
    case `if`(cond: Expr, ifTrue:Expr, ifFalse:Expr)
    case `let`(name: Var, bind: Expr, body: Expr)
    case `var`(name: Var)
    case letRec(name: Var, args: [Var], bind: Expr, body: Expr)
    case app(function: ID, args: [Expr])
    case tuple(elements: [Expr])
    case letTuple(vars: [Var], binding: Expr, body: Expr)
    case array(size: Expr, element: Expr)
    case get(array: Expr, index: Expr)
    case put(array: Expr, index: Expr, value: Expr)
}

// Type
public indirect enum Type: AutoEquatable, AutoHashable, AutoEnum {
    case unit
    case int
    case float
    case bool
    case `func`(args: [Type], ret: Type)
    case tuple(elements: [Type])
    case array(element: Type)
    case typeVar(name: String)
}
