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
