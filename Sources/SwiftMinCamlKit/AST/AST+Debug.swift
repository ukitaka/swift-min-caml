//
//  AST+Debug.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/30.
//

import Foundation

extension Expr: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unit:
            return "()"
        case let .bool(v):
            return v.description
        case let .int(v):
            return v.description
        case let .float(v):
            return v.description
        case .not(let op):
            return "(not \(op))"
        case .neg(let op):
            return "(-\(op))"
        case .add(let lhs, let rhs):
            return "\(lhs) + \(rhs)"
        case .sub(let lhs, let rhs):
            return "\(lhs) - \(rhs)"
        case .mul(let lhs, let rhs):
            return "\(lhs) * \(rhs)"
        case .div(let lhs, let rhs):
            return "\(lhs) / \(rhs)"
        case .fneg(let op):
            return "(-\(op))"
        case .fadd(let lhs, let rhs):
            return "\(lhs) + \(rhs)"
        case .fsub(let lhs, let rhs):
            return "\(lhs) - \(rhs)"
        case .fmul(let lhs, let rhs):
            return "\(lhs) * \(rhs)"
        case .fdiv(let lhs, let rhs):
            return "\(lhs) / \(rhs)"
        case .eq(let lhs, let rhs):
            return "\(lhs) == \(rhs)"
        case .le(let lhs, let rhs):
            return "\(lhs) <= \(rhs)"
        case .if(let cond, let ifTrue, let ifFalse):
            return "if (\(cond)) then (\(ifTrue)) else (\(ifFalse))"
        case .let(let name, let bind, let body):
            return "let \(name) = \(bind) in \(body)"
        case .var(let name):
            return name.description
        case .letRec(let funcDef, let body):
            return "let rec \(funcDef) in \(body)"
        case .app(let function, let args):
            return function.description + args.map { $0.description }.joined(separator: " ")
        case .tuple(let elements):
            return "(" + elements.map { $0.description }.joined(separator: ",")
        case .letTuple(let vars, let binding, let body):
            return "let (" + vars.map { $0.description }.joined(separator: ",") + ")  = \(binding) in \(body)"
        case .array(let size, let element):
            return "Array.create \(size) \(element)"
        case .get(let array, let index):
            return "\(array).(\(index)"
        case .put(let array, let index, let value):
            return "\(array).(\(index) = \(value)"
        }
    }
}

extension FuncDef: CustomStringConvertible {
    public var description: String {
        return name.description + " " + args.map { $0.description }.joined(separator: " ") + " = " + body.description
    }
}

extension TypedVar: CustomStringConvertible {
    public var description: String {
        return self.name.description + ": " + self.type.description
    }
}

extension Type: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unit:
            return "Unit"
        case .int:
            return "Int"
        case .float:
            return "Float"
        case .bool:
            return "Bool"
        case .func(let args, let ret):
            return "(" + args.map { $0.description }.joined(separator: ",") + ") -> " + ret.description
        case .tuple(let elements):
            return "(" + elements.map { $0.description }.joined(separator: ",") + ")"
        case .array(let element):
            return "[\(element)]"
        case .typeVar(let name):
            return name
        }
    }
}
