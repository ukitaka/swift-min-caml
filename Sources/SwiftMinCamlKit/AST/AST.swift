//
//  AST.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import Tagged

/// ID
public enum IDTag {}

public typealias ID = Tagged<IDTag, String>
public typealias Var = ID

public extension Tagged where Tag == IDTag, RawValue == String {
    static func fromString(_ str: String) -> ID {
        return Var(stringLiteral: str)
    }
    
    private static var varCounter: Int = 0

    static func tmpVar() -> Var {
        defer { varCounter += 1 }
        return Var(rawValue: "tmp_var\(varCounter)")
    }
}

/// TypeVar
public typealias TypeVar = Type

/// TypedVar
public struct TypedVar: Hashable {
    var name: ID
    var type: Type
    
    init(name: ID, type: Type = Type.newTypeVar()) {
        self.name = name
        self.type = type
    }
}

extension TypedVar {
    private static var counter: Int = 0
    
    static func tmpVar(type: Type = .unit) -> TypedVar {
        defer { counter += 1 }
        return TypedVar(name: ID(rawValue: "tmp\(counter)"), type: type)
    }
    
    func assign(type: Type) -> TypedVar {
        precondition(self.type.isTypeVar)
        return TypedVar(name: self.name, type: type)
    }
}

/// FuncDef
public struct FuncDef: Hashable {
    var name: TypedVar
    var args: [TypedVar]
    var body: Expr
}

/// Expressions
public indirect enum Expr: AutoHashable, AutoEquatable, AutoEnum {
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
    case fneg(op: Expr)             // unary -
    case fadd(lhs: Expr, rhs: Expr) // +
    case fsub(lhs: Expr, rhs: Expr) // -
    case fmul(lhs: Expr, rhs: Expr) // *
    case fdiv(lhs: Expr, rhs: Expr) // /
    case eq(lhs: Expr, rhs: Expr)   // ==
    case le(lhs: Expr, rhs: Expr)   // <=
    case `if`(cond: Expr, ifTrue:Expr, ifFalse:Expr)
    case `let`(name: TypedVar, bind: Expr, body: Expr)
    case `var`(name: Var)
    case letRec(funcDef: FuncDef, body: Expr)
    case app(function: Expr, args: [Expr])
    case tuple(elements: [Expr])
    case letTuple(vars: [TypedVar], binding: Expr, body: Expr)
    case array(size: Expr, element: Expr)
    case get(array: Expr, index: Expr)
    case put(array: Expr, index: Expr, value: Expr)
}

/// Normalized FuncDef
public struct NormalizedFuncDef: Hashable {
    var name: TypedVar
    var args: [TypedVar]
    var body: NormalizedExpr
}

/// Normalized expression
public indirect enum NormalizedExpr: AutoHashable, AutoEquatable, AutoEnum {
    case unit
    case int(Int)
    case float(Double)
    case not(op: Var)               // !
    case neg(op: Var)               // unary -
    case add(lhs: Var, rhs: Var)    // +
    case sub(lhs: Var, rhs: Var)    // -
    case mul(lhs: Var, rhs: Var)    // *
    case div(lhs: Var, rhs: Var)    // /
    case fneg(op: Var)              // unary -
    case fadd(lhs: Var, rhs: Var)   // +
    case fsub(lhs: Var, rhs: Var)   // -
    case fmul(lhs: Var, rhs: Var)   // *
    case fdiv(lhs: Var, rhs: Var)   // /
    case ifEq(lhs: Var, rhs: Var, ifTrue:NormalizedExpr, ifFalse:NormalizedExpr) // if `lhs` == `rhs` then `ifTrue` else `ifFalse`
    case ifLE(lhs: Var, rhs: Var, ifTrue:NormalizedExpr, ifFalse:NormalizedExpr) // if `lhs` <= `rhs` then `ifTrue` else `ifFalse`
    case `let`(name: TypedVar, bind: NormalizedExpr, body: NormalizedExpr)
    case `var`(name: Var)
    case letRec(funcDef: NormalizedFuncDef, body: NormalizedExpr)
    case app(function: ID, args: [Var])
    case tuple(elements: [Var])
    case letTuple(vars: [TypedVar], binding: Var, body: NormalizedExpr)
    case array(size: Var, element: Var)
    case get(array: Var, index: Var)
    case put(array: Var, index: Var, value: Var)
    case extArray(elements: [Var])
    case extFunApp(function: ID, args: [Var])
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

extension Type {
    private static var counter: Int = 0
    static func newTypeVar() -> Type {
        defer {
            counter += 1
        }
        return .typeVar(name: "TypeVar\(counter)")
    }
    
    static func newTypeVars(n: Int) -> [Type] {
        return (1...n).map { _ in newTypeVar() }
    }
}
