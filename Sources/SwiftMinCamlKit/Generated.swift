// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

public extension Type {
    public var isUnit: Bool {
        switch self {
        case .unit: return true
        default: return false
        }
    }

    public var isInt: Bool {
        switch self {
        case .int: return true
        default: return false
        }
    }

    public var isFloat: Bool {
        switch self {
        case .float: return true
        default: return false
        }
    }

    public var isBool: Bool {
        switch self {
        case .bool: return true
        default: return false
        }
    }

    public var isFunc: Bool {
        switch self {
        case .func: return true
        default: return false
        }
    }

    public struct FuncType {
        public let args: [Type]
        public let ret: Type
    }

    public var asFunc: FuncType? {
        switch self {
        case let .func(args, ret):
            return FuncType(
                args: args,
                ret: ret
            )
        default:
            return nil
        }
    }

    public var isTuple: Bool {
        switch self {
        case .tuple: return true
        default: return false
        }
    }

    public var asTuple: [Type]? {
        switch self {
        case let .tuple(elements):
            return elements
        default:
            return nil
        }
    }

    public var isArray: Bool {
        switch self {
        case .array: return true
        default: return false
        }
    }

    public var asArray: Type? {
        switch self {
        case let .array(element):
            return element
        default:
            return nil
        }
    }

    public var isTypeVar: Bool {
        switch self {
        case .typeVar: return true
        default: return false
        }
    }

    public var asTypeVar: String? {
        switch self {
        case let .typeVar(name):
            return name
        default:
            return nil
        }
    }
}

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatable for classes, protocols, structs

// MARK: - AutoEquatable for Enums

// MARK: - Expr AutoEquatable

extension Expr: Equatable {}
public func == (lhs: Expr, rhs: Expr) -> Bool {
    switch (lhs, rhs) {
    case (.unit, .unit):
        return true
    case let (.bool(lhs), .bool(rhs)):
        return lhs == rhs
    case let (.int(lhs), .int(rhs)):
        return lhs == rhs
    case let (.float(lhs), .float(rhs)):
        return lhs == rhs
    case let (.not(lhs), .not(rhs)):
        return lhs == rhs
    case let (.neg(lhs), .neg(rhs)):
        return lhs == rhs
    case let (.add(lhs), .add(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.sub(lhs), .sub(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.mul(lhs), .mul(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.div(lhs), .div(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.fadd(lhs), .fadd(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.fsub(lhs), .fsub(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.fmul(lhs), .fmul(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.fdiv(lhs), .fdiv(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.eq(lhs), .eq(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.le(lhs), .le(rhs)):
        if lhs.lhs != rhs.lhs { return false }
        if lhs.rhs != rhs.rhs { return false }
        return true
    case let (.if(lhs), .if(rhs)):
        if lhs.cond != rhs.cond { return false }
        if lhs.ifTrue != rhs.ifTrue { return false }
        if lhs.ifFalse != rhs.ifFalse { return false }
        return true
    case let (.let(lhs), .let(rhs)):
        if lhs.name != rhs.name { return false }
        if lhs.bind != rhs.bind { return false }
        if lhs.body != rhs.body { return false }
        return true
    case let (.var(lhs), .var(rhs)):
        return lhs == rhs
    case let (.letRec(lhs), .letRec(rhs)):
        if lhs.name != rhs.name { return false }
        if lhs.args != rhs.args { return false }
        if lhs.bind != rhs.bind { return false }
        if lhs.body != rhs.body { return false }
        return true
    case let (.app(lhs), .app(rhs)):
        if lhs.function != rhs.function { return false }
        if lhs.args != rhs.args { return false }
        return true
    case let (.tuple(lhs), .tuple(rhs)):
        return lhs == rhs
    case let (.letTuple(lhs), .letTuple(rhs)):
        if lhs.vars != rhs.vars { return false }
        if lhs.binding != rhs.binding { return false }
        if lhs.body != rhs.body { return false }
        return true
    case let (.array(lhs), .array(rhs)):
        if lhs.size != rhs.size { return false }
        if lhs.element != rhs.element { return false }
        return true
    case let (.get(lhs), .get(rhs)):
        if lhs.array != rhs.array { return false }
        if lhs.index != rhs.index { return false }
        return true
    case let (.put(lhs), .put(rhs)):
        if lhs.array != rhs.array { return false }
        if lhs.index != rhs.index { return false }
        if lhs.value != rhs.value { return false }
        return true
    default: return false
    }
}

// MARK: - Type AutoEquatable

extension Type: Equatable {}
public func == (lhs: Type, rhs: Type) -> Bool {
    switch (lhs, rhs) {
    case (.unit, .unit):
        return true
    case (.int, .int):
        return true
    case (.float, .float):
        return true
    case (.bool, .bool):
        return true
    case let (.func(lhs), .func(rhs)):
        if lhs.args != rhs.args { return false }
        if lhs.ret != rhs.ret { return false }
        return true
    case let (.tuple(lhs), .tuple(rhs)):
        return lhs == rhs
    case let (.array(lhs), .array(rhs)):
        return lhs == rhs
    case let (.typeVar(lhs), .typeVar(rhs)):
        return lhs == rhs
    default: return false
    }
}

// swiftlint:disable file_length
// swiftlint:disable line_length

fileprivate func combineHashes(_ hashes: [Int]) -> Int {
    return hashes.reduce(0, combineHashValues)
}

fileprivate func combineHashValues(_ initial: Int, _ other: Int) -> Int {
    #if arch(x86_64) || arch(arm64)
        let magic: UInt = 0x9E37_79B9_7F4A_7C15
    #elseif arch(i386) || arch(arm)
        let magic: UInt = 0x9E37_79B9
    #endif
    var lhs = UInt(bitPattern: initial)
    let rhs = UInt(bitPattern: other)
    lhs ^= rhs &+ magic &+ (lhs << 6) &+ (lhs >> 2)
    return Int(bitPattern: lhs)
}

fileprivate func hashArray<T: Hashable>(_ array: [T]?) -> Int {
    guard let array = array else {
        return 0
    }
    return array.reduce(5381) {
        ($0 << 5) &+ $0 &+ $1.hashValue
    }
}

#if swift(>=4.0)
    fileprivate func hashDictionary<T, U: Hashable>(_ dictionary: [T: U]?) -> Int {
        guard let dictionary = dictionary else {
            return 0
        }
        return dictionary.reduce(5381) {
            combineHashValues($0, combineHashValues($1.key.hashValue, $1.value.hashValue))
        }
    }

#else
    fileprivate func hashDictionary<T: Hashable, U: Hashable>(_ dictionary: [T: U]?) -> Int {
        guard let dictionary = dictionary else {
            return 0
        }
        return dictionary.reduce(5381) {
            combineHashValues($0, combineHashValues($1.key.hashValue, $1.value.hashValue))
        }
    }
#endif

// MARK: - AutoHashable for classes, protocols, structs

// MARK: - AutoHashable for Enums

// MARK: - Expr AutoHashable

extension Expr: Hashable {
    public var hashValue: Int {
        switch self {
        case .unit:
            return 1.hashValue
        case let .bool(data):
            return combineHashes([2, data.hashValue])
        case let .int(data):
            return combineHashes([3, data.hashValue])
        case let .float(data):
            return combineHashes([4, data.hashValue])
        case let .not(data):
            return combineHashes([5, data.hashValue])
        case let .neg(data):
            return combineHashes([6, data.hashValue])
        case let .add(data):
            return combineHashes([7, data.lhs.hashValue, data.rhs.hashValue])
        case let .sub(data):
            return combineHashes([8, data.lhs.hashValue, data.rhs.hashValue])
        case let .mul(data):
            return combineHashes([9, data.lhs.hashValue, data.rhs.hashValue])
        case let .div(data):
            return combineHashes([10, data.lhs.hashValue, data.rhs.hashValue])
        case let .fadd(data):
            return combineHashes([11, data.lhs.hashValue, data.rhs.hashValue])
        case let .fsub(data):
            return combineHashes([12, data.lhs.hashValue, data.rhs.hashValue])
        case let .fmul(data):
            return combineHashes([13, data.lhs.hashValue, data.rhs.hashValue])
        case let .fdiv(data):
            return combineHashes([14, data.lhs.hashValue, data.rhs.hashValue])
        case let .eq(data):
            return combineHashes([15, data.lhs.hashValue, data.rhs.hashValue])
        case let .le(data):
            return combineHashes([16, data.lhs.hashValue, data.rhs.hashValue])
        case let .if(data):
            return combineHashes([17, data.cond.hashValue, data.ifTrue.hashValue, data.ifFalse.hashValue])
        case let .let(data):
            return combineHashes([18, data.name.hashValue, data.bind.hashValue, data.body.hashValue])
        case let .var(data):
            return combineHashes([19, data.hashValue])
        case let .letRec(data):
            return combineHashes([20, data.name.hashValue, data.args.hashValue, data.bind.hashValue, data.body.hashValue])
        case let .app(data):
            return combineHashes([21, data.function.hashValue, data.args.hashValue])
        case let .tuple(data):
            return combineHashes([22, data.hashValue])
        case let .letTuple(data):
            return combineHashes([23, data.vars.hashValue, data.binding.hashValue, data.body.hashValue])
        case let .array(data):
            return combineHashes([24, data.size.hashValue, data.element.hashValue])
        case let .get(data):
            return combineHashes([25, data.array.hashValue, data.index.hashValue])
        case let .put(data):
            return combineHashes([26, data.array.hashValue, data.index.hashValue, data.value.hashValue])
        }
    }
}

// MARK: - Type AutoHashable

extension Type: Hashable {
    public var hashValue: Int {
        switch self {
        case .unit:
            return 1.hashValue
        case .int:
            return 2.hashValue
        case .float:
            return 3.hashValue
        case .bool:
            return 4.hashValue
        case let .func(data):
            return combineHashes([5, data.args.hashValue, data.ret.hashValue])
        case let .tuple(data):
            return combineHashes([6, data.hashValue])
        case let .array(data):
            return combineHashes([7, data.hashValue])
        case let .typeVar(data):
            return combineHashes([8, data.hashValue])
        }
    }
}

// MARK: - AutoHashable for Array

extension Array: Hashable where Element: Hashable {
    public var hashValue: Int {
        return reduce(5381) {
            ($0 << 5) &+ $0 &+ $1.hashValue
        }
    }
}

public indirect enum TypedExpr {
    case unit(type: Type)
    case bool(: Bool, type: Type)
    case int(: Int, type: Type)
    case float(: Double, type: Type)
    case not(op: TypedExpr, type: Type)
    case neg(op: TypedExpr, type: Type)
    case add(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case sub(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case mul(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case div(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case fadd(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case fsub(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case fmul(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case fdiv(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case eq(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case le(lhs: TypedExpr, rhs: TypedExpr, type: Type)
    case `if`(cond: TypedExpr, ifTrue: TypedExpr, ifFalse: TypedExpr, type: Type)
    case `let`(name: Var, bind: TypedExpr, body: TypedExpr, type: Type)
    case `var`(name: Var, type: Type)
    case letRec(name: Var, args: [Var], bind: TypedExpr, body: TypedExpr, type: Type)
    case app(function: ID, args: [TypedExpr], type: Type)
    case tuple(elements: [TypedExpr], type: Type)
    case letTuple(vars: [Var], binding: TypedExpr, body: TypedExpr, type: Type)
    case array(size: TypedExpr, element: TypedExpr, type: Type)
    case get(array: TypedExpr, index: TypedExpr, type: Type)
    case put(array: TypedExpr, index: TypedExpr, value: TypedExpr, type: Type)
}

public extension TypedExpr {
    var type: Type {
        switch self {
        case let .unit(type):
            return type
        case let .bool(_, type):
            return type
        case let .int(_, type):
            return type
        case let .float(_, type):
            return type
        case let .not(_, type):
            return type
        case let .neg(_, type):
            return type
        case let .add(_, _, type):
            return type
        case let .sub(_, _, type):
            return type
        case let .mul(_, _, type):
            return type
        case let .div(_, _, type):
            return type
        case let .fadd(_, _, type):
            return type
        case let .fsub(_, _, type):
            return type
        case let .fmul(_, _, type):
            return type
        case let .fdiv(_, _, type):
            return type
        case let .eq(_, _, type):
            return type
        case let .le(_, _, type):
            return type
        case let .if(_, _, _, type):
            return type
        case let .let(_, _, _, type):
            return type
        case let .var(_, type):
            return type
        case let .letRec(_, _, _, _, type):
            return type
        case let .app(_, _, type):
            return type
        case let .tuple(_, type):
            return type
        case let .letTuple(_, _, _, type):
            return type
        case let .array(_, _, type):
            return type
        case let .get(_, _, type):
            return type
        case let .put(_, _, _, type):
            return type
        }
    }

    func untyped() -> Expr {
        switch self {
        case let .unit:
            return .unit()
        case let .bool:
            return .bool(:)
        case let .int:
            return .int(:)
        case let .float:
            return .float(:)
        case let .not(op, _):
            return .not(op: op.untyped())
        case let .neg(op, _):
            return .neg(op: op.untyped())
        case let .add(lhs, rhs, _):
            return .add(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .sub(lhs, rhs, _):
            return .sub(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .mul(lhs, rhs, _):
            return .mul(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .div(lhs, rhs, _):
            return .div(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .fadd(lhs, rhs, _):
            return .fadd(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .fsub(lhs, rhs, _):
            return .fsub(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .fmul(lhs, rhs, _):
            return .fmul(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .fdiv(lhs, rhs, _):
            return .fdiv(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .eq(lhs, rhs, _):
            return .eq(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .le(lhs, rhs, _):
            return .le(lhs: lhs.untyped(), rhs: rhs.untyped())
        case let .if(cond, ifTrue, ifFalse, _):
            return .if(cond: cond.untyped(), ifTrue: ifTrue.untyped(), ifFalse: ifFalse.untyped())
        case let .let(name, bind, body, _):
            return .let(name: name, bind: bind.untyped(), body: body.untyped())
        case let .var(name, _):
            return .var(name: name)
        case let .letRec(name, args, bind, body, _):
            return .letRec(name: name, args: args, bind: bind.untyped(), body: body.untyped())
        case let .app(function, args, _):
            return .app(function: function, args: args.map { $0.untyped() })
        case let .tuple(elements, _):
            return .tuple(elements: elements.map { $0.untyped() })
        case let .letTuple(vars, binding, body, _):
            return .letTuple(vars: vars, binding: binding.untyped(), body: body.untyped())
        case let .array(size, element, _):
            return .array(size: size.untyped(), element: element.untyped())
        case let .get(array, index, _):
            return .get(array: array.untyped(), index: index.untyped())
        case let .put(array, index, value, _):
            return .put(array: array.untyped(), index: index.untyped(), value: value.untyped())
        }
    }

    func typed(type: Type) -> TypedExpr {
        switch self {
        case let .unit:
            return .unit(type: type)
        case let .bool:
            return .bool(:, type: type)
        case let .int:
            return .int(:, type: type)
        case let .float:
            return .float(:, type: type)
        case let .not(op, _):
            return .not(op: op, type: type)
        case let .neg(op, _):
            return .neg(op: op, type: type)
        case let .add(lhs, rhs, _):
            return .add(lhs: lhs, rhs: rhs, type: type)
        case let .sub(lhs, rhs, _):
            return .sub(lhs: lhs, rhs: rhs, type: type)
        case let .mul(lhs, rhs, _):
            return .mul(lhs: lhs, rhs: rhs, type: type)
        case let .div(lhs, rhs, _):
            return .div(lhs: lhs, rhs: rhs, type: type)
        case let .fadd(lhs, rhs, _):
            return .fadd(lhs: lhs, rhs: rhs, type: type)
        case let .fsub(lhs, rhs, _):
            return .fsub(lhs: lhs, rhs: rhs, type: type)
        case let .fmul(lhs, rhs, _):
            return .fmul(lhs: lhs, rhs: rhs, type: type)
        case let .fdiv(lhs, rhs, _):
            return .fdiv(lhs: lhs, rhs: rhs, type: type)
        case let .eq(lhs, rhs, _):
            return .eq(lhs: lhs, rhs: rhs, type: type)
        case let .le(lhs, rhs, _):
            return .le(lhs: lhs, rhs: rhs, type: type)
        case let .if(cond, ifTrue, ifFalse, _):
            return .if(cond: cond, ifTrue: ifTrue, ifFalse: ifFalse, type: type)
        case let .let(name, bind, body, _):
            return .let(name: name, bind: bind, body: body, type: type)
        case let .var(name, _):
            return .var(name: name, type: type)
        case let .letRec(name, args, bind, body, _):
            return .letRec(name: name, args: args, bind: bind, body: body, type: type)
        case let .app(function, args, _):
            return .app(function: function, args: args, type: type)
        case let .tuple(elements, _):
            return .tuple(elements: elements, type: type)
        case let .letTuple(vars, binding, body, _):
            return .letTuple(vars: vars, binding: binding, body: body, type: type)
        case let .array(size, element, _):
            return .array(size: size, element: element, type: type)
        case let .get(array, index, _):
            return .get(array: array, index: index, type: type)
        case let .put(array, index, value, _):
            return .put(array: array, index: index, value: value, type: type)
        }
    }
}

public extension Expr {
    func constraintTyping() -> TypedExpr {
        switch self {
        case let .unit():
            return .unit(type: Type.newTypeVar())
        case let .bool():
            return .bool(:, type: Type.newTypeVar())
        case let .int():
            return .int(:, type: Type.newTypeVar())
        case let .float():
            return .float(:, type: Type.newTypeVar())
        case let .not(op):
            return .not(op: op.constraintTyping(), type: Type.newTypeVar())
        case let .neg(op):
            return .neg(op: op.constraintTyping(), type: Type.newTypeVar())
        case let .add(lhs, rhs):
            return .add(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .sub(lhs, rhs):
            return .sub(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .mul(lhs, rhs):
            return .mul(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .div(lhs, rhs):
            return .div(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .fadd(lhs, rhs):
            return .fadd(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .fsub(lhs, rhs):
            return .fsub(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .fmul(lhs, rhs):
            return .fmul(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .fdiv(lhs, rhs):
            return .fdiv(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .eq(lhs, rhs):
            return .eq(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .le(lhs, rhs):
            return .le(lhs: lhs.constraintTyping(), rhs: rhs.constraintTyping(), type: Type.newTypeVar())
        case let .if(cond, ifTrue, ifFalse):
            return .if(cond: cond.constraintTyping(), ifTrue: ifTrue.constraintTyping(), ifFalse: ifFalse.constraintTyping(), type: Type.newTypeVar())
        case let .let(name, bind, body):
            return .let(name: name, bind: bind.constraintTyping(), body: body.constraintTyping(), type: Type.newTypeVar())
        case let .var(name):
            return .var(name: name, type: Type.newTypeVar())
        case let .letRec(name, args, bind, body):
            return .letRec(name: name, args: args, bind: bind.constraintTyping(), body: body.constraintTyping(), type: Type.newTypeVar())
        case let .app(function, args):
            return .app(function: function, args: args.map { $0.constraintTyping() }, type: Type.newTypeVar())
        case let .tuple(elements):
            return .tuple(elements: elements.map { $0.constraintTyping() }, type: Type.newTypeVar())
        case let .letTuple(vars, binding, body):
            return .letTuple(vars: vars, binding: binding.constraintTyping(), body: body.constraintTyping(), type: Type.newTypeVar())
        case let .array(size, element):
            return .array(size: size.constraintTyping(), element: element.constraintTyping(), type: Type.newTypeVar())
        case let .get(array, index):
            return .get(array: array.constraintTyping(), index: index.constraintTyping(), type: Type.newTypeVar())
        case let .put(array, index, value):
            return .put(array: array.constraintTyping(), index: index.constraintTyping(), value: value.constraintTyping(), type: Type.newTypeVar())
        }
    }
}
