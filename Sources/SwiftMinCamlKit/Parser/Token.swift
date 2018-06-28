//
//  Token.swift
//  SwiftMinCamlKit
//
//  Created by Yuki Takahashi on 2018/06/28.
//

enum Token {
    case keyword // for let, rec, int ..
    case punctuation // for (, ) ..
    case identifier(String) // for IDENTIFIER
    case integerLiteral(Int)
    case floatLiteral(Double)
    case boolLiteral(Bool)
}

extension Token {
    func asInt() -> Int {
        switch self {
        case let .integerLiteral(i):
            return i
        default:
            fatalError("\(self) is not integer value.")
        }
    }
    
    func asFloat() -> Double {
        switch self {
        case let .floatLiteral(f):
            return f
        default:
            fatalError("\(self) is not float value.")
        }
    }
    
    func asBool() -> Bool {
        switch self {
        case let .boolLiteral(b):
            return b
        default:
            fatalError("\(self) is not boolean value.")
        }
    }
    
    func asID() -> ID {
        switch self {
        case let .identifier(id):
            return ID(rawValue: id)
        default:
            fatalError("\(self) is not identifier.")
        }
    }
}
