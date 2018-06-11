//
//  AST.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/11.
//

import Foundation

protocol Node: AutoEquatable, AutoHashable { }

/// Constants
enum Const: Node {
    case integer(Int)
    case float(Float)
    case bool(Bool)
}

/// Expressions
enum Expr: Node {
    case const(Const)
}
