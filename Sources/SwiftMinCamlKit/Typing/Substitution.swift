//
//  Substitution.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/28.
//

struct Substitution {
    private let map: [TypeVar: Type]
    
    init() {
        self.map = [:]
    }
    
    init(_ map: [TypeVar: Type]) {
        self.map = map
    }
    
    func merging(other: Substitution) -> Substitution {
        return Substitution(map.merging(other.map, uniquingKeysWith: { _, t in t }))
    }
    
    static func merging(lhs: Substitution, rhs: Substitution) -> Substitution {
        return lhs.merging(other: rhs)
    }
    
    func removing(variables: [TypeVar]) -> Substitution {
        var map = self.map
        for variable in variables {
            map.removeValue(forKey: variable)
        }
        return Substitution(map)
    }
    
    subscript(variable: TypeVar) -> Type? {
        return map[variable]
    }
    
}

extension Substitution: CustomStringConvertible {
    var description: String {
        return map.map { "\($0.key) => \($0.value)" }.joined(separator: "\n")
    }
}

extension Type {
    func apply(_ substitution: Substitution) -> Type {
        switch self {
        case .typeVar:
            guard let type = substitution[self] else {
                return self
            }
            return type
        case let .func(args: args, ret: ret):
            return .func(args: args.map { arg in arg.apply(substitution) }, ret: ret.apply(substitution))
        case let .tuple(elements: elements):
            return .tuple(elements: elements.map { e in e.apply(substitution) })
        case let .array(element: element):
            return .array(element: element.apply(substitution))
        default:
            return self
        }
    }
}

extension TypedVar {
    func apply(_ substitution: Substitution) -> TypedVar {
        return TypedVar(name: self.name, type: type.apply(substitution))
    }
}

extension FuncDef {
    func apply(_ substituion: Substitution) -> FuncDef {
        return FuncDef(
            name: self.name.apply(substituion),
            args: args.map{ $0.apply(substituion) },
            body: body.apply(substituion))
    }
}

extension Expr {
    func apply(_ substitution: Substitution) -> Expr {
        switch self {
        case .unit:
            return self
        case .bool:
            return self
        case .int:
            return self
        case .float:
            return self
        case let .not(op: op):
            return .not(op: op.apply(substitution))
        case let .neg(op: op):
            return .neg(op: op.apply(substitution))
        case let .add(lhs: lhs, rhs: rhs):
            return .add(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .sub(lhs: lhs, rhs: rhs):
            return .sub(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .mul(lhs: lhs, rhs: rhs):
            return .mul(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .div(lhs: lhs, rhs: rhs):
            return .div(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .fneg(op: op):
            return .fneg(op: op.apply(substitution))
        case let .fadd(lhs: lhs, rhs: rhs):
            return .fadd(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .fsub(lhs: lhs, rhs: rhs):
            return .fsub(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .fmul(lhs: lhs, rhs: rhs):
            return .fmul(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .fdiv(lhs: lhs, rhs: rhs):
            return .fdiv(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .eq(lhs: lhs, rhs: rhs):
            return .eq(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .le(lhs: lhs, rhs: rhs):
            return .le(lhs: lhs.apply(substitution), rhs: rhs.apply(substitution))
        case let .if(cond, ifTrue, ifFalse):
            return .if(cond: cond.apply(substitution), ifTrue: ifTrue.apply(substitution), ifFalse: ifFalse.apply(substitution))
        case let .let(name, bind, body):
            return .let(name: name.apply(substitution), bind: bind.apply(substitution), body: body.apply(substitution))
        case .var:
            return self
        case let .letRec(funcDef: funcDef, body: body):
            return .letRec(funcDef: funcDef.apply(substitution), body: body.apply(substitution))
        case let .app(function: function, args: args):
            return .app(function: function.apply(substitution), args: args.map { $0.apply(substitution) })
        case let .tuple(elements: elements):
            return .tuple(elements: elements.map { $0.apply(substitution) })
        case let .letTuple(vars: vars, binding: binding, body: body):
            return .letTuple(vars: vars.map { $0.apply(substitution) }, binding: binding.apply(substitution), body: body.apply(substitution))
        case let .array(size: size, element: element):
            return .array(size: size.apply(substitution), element: element.apply(substitution))
        case let .get(array: array, index: index):
            return .get(array: array.apply(substitution), index: index.apply(substitution))
        case let .put(array: array, index: index, value: value):
            return .put(array: array.apply(substitution), index: index.apply(substitution), value: value.apply(substitution))
        }
    }
}
