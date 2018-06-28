// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

public extension Expr {
    public var isUnit: Bool {
        switch self {
        case .unit: return true
        default: return false
        }
    }

    public var isBool: Bool {
        switch self {
        case .bool: return true
        default: return false
        }
    }

    public var asBool: Bool? {
        switch self {
        case let .bool(bool):
            return bool
        default:
            return nil
        }
    }

    public var isInt: Bool {
        switch self {
        case .int: return true
        default: return false
        }
    }

    public var asInt: Int? {
        switch self {
        case let .int(int):
            return int
        default:
            return nil
        }
    }

    public var isFloat: Bool {
        switch self {
        case .float: return true
        default: return false
        }
    }

    public var asFloat: Double? {
        switch self {
        case let .float(float):
            return float
        default:
            return nil
        }
    }

    public var isNot: Bool {
        switch self {
        case .not: return true
        default: return false
        }
    }

    public var asNot: Expr? {
        switch self {
        case let .not(op):
            return op
        default:
            return nil
        }
    }

    public var isNeg: Bool {
        switch self {
        case .neg: return true
        default: return false
        }
    }

    public var asNeg: Expr? {
        switch self {
        case let .neg(op):
            return op
        default:
            return nil
        }
    }

    public var isAdd: Bool {
        switch self {
        case .add: return true
        default: return false
        }
    }

    public struct AddExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asAdd: AddExpr? {
        switch self {
        case let .add(lhs, rhs):
            return AddExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isSub: Bool {
        switch self {
        case .sub: return true
        default: return false
        }
    }

    public struct SubExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asSub: SubExpr? {
        switch self {
        case let .sub(lhs, rhs):
            return SubExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isFneg: Bool {
        switch self {
        case .fneg: return true
        default: return false
        }
    }

    public var asFneg: Expr? {
        switch self {
        case let .fneg(op):
            return op
        default:
            return nil
        }
    }

    public var isFadd: Bool {
        switch self {
        case .fadd: return true
        default: return false
        }
    }

    public struct FaddExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asFadd: FaddExpr? {
        switch self {
        case let .fadd(lhs, rhs):
            return FaddExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isFsub: Bool {
        switch self {
        case .fsub: return true
        default: return false
        }
    }

    public struct FsubExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asFsub: FsubExpr? {
        switch self {
        case let .fsub(lhs, rhs):
            return FsubExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isFmul: Bool {
        switch self {
        case .fmul: return true
        default: return false
        }
    }

    public struct FmulExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asFmul: FmulExpr? {
        switch self {
        case let .fmul(lhs, rhs):
            return FmulExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isFdiv: Bool {
        switch self {
        case .fdiv: return true
        default: return false
        }
    }

    public struct FdivExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asFdiv: FdivExpr? {
        switch self {
        case let .fdiv(lhs, rhs):
            return FdivExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isEq: Bool {
        switch self {
        case .eq: return true
        default: return false
        }
    }

    public struct EqExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asEq: EqExpr? {
        switch self {
        case let .eq(lhs, rhs):
            return EqExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isLe: Bool {
        switch self {
        case .le: return true
        default: return false
        }
    }

    public struct LeExpr {
        public let lhs: Expr
        public let rhs: Expr
    }

    public var asLe: LeExpr? {
        switch self {
        case let .le(lhs, rhs):
            return LeExpr(
                lhs: lhs,
                rhs: rhs
            )
        default:
            return nil
        }
    }

    public var isIf: Bool {
        switch self {
        case .if: return true
        default: return false
        }
    }

    public struct IfExpr {
        public let cond: Expr
        public let ifTrue: Expr
        public let ifFalse: Expr
    }

    public var asIf: IfExpr? {
        switch self {
        case let .if(cond, ifTrue, ifFalse):
            return IfExpr(
                cond: cond,
                ifTrue: ifTrue,
                ifFalse: ifFalse
            )
        default:
            return nil
        }
    }

    public var isLet: Bool {
        switch self {
        case .let: return true
        default: return false
        }
    }

    public struct LetExpr {
        public let name: TypedVar
        public let bind: Expr
        public let body: Expr
    }

    public var asLet: LetExpr? {
        switch self {
        case let .let(name, bind, body):
            return LetExpr(
                name: name,
                bind: bind,
                body: body
            )
        default:
            return nil
        }
    }

    public var isVar: Bool {
        switch self {
        case .var: return true
        default: return false
        }
    }

    public var asVar: Var? {
        switch self {
        case let .var(name):
            return name
        default:
            return nil
        }
    }

    public var isLetRec: Bool {
        switch self {
        case .letRec: return true
        default: return false
        }
    }

    public struct LetRecExpr {
        public let funcDef: FuncDef
        public let bind: Expr
    }

    public var asLetRec: LetRecExpr? {
        switch self {
        case let .letRec(funcDef, bind):
            return LetRecExpr(
                funcDef: funcDef,
                bind: bind
            )
        default:
            return nil
        }
    }

    public var isApp: Bool {
        switch self {
        case .app: return true
        default: return false
        }
    }

    public struct AppExpr {
        public let function: Expr
        public let args: [Expr]
    }

    public var asApp: AppExpr? {
        switch self {
        case let .app(function, args):
            return AppExpr(
                function: function,
                args: args
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

    public var asTuple: [Expr]? {
        switch self {
        case let .tuple(elements):
            return elements
        default:
            return nil
        }
    }

    public var isLetTuple: Bool {
        switch self {
        case .letTuple: return true
        default: return false
        }
    }

    public struct LetTupleExpr {
        public let vars: [TypedVar]
        public let binding: Expr
        public let body: Expr
    }

    public var asLetTuple: LetTupleExpr? {
        switch self {
        case let .letTuple(vars, binding, body):
            return LetTupleExpr(
                vars: vars,
                binding: binding,
                body: body
            )
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

    public struct ArrayExpr {
        public let size: Expr
        public let element: Expr
    }

    public var asArray: ArrayExpr? {
        switch self {
        case let .array(size, element):
            return ArrayExpr(
                size: size,
                element: element
            )
        default:
            return nil
        }
    }

    public var isGet: Bool {
        switch self {
        case .get: return true
        default: return false
        }
    }

    public struct GetExpr {
        public let array: Expr
        public let index: Expr
    }

    public var asGet: GetExpr? {
        switch self {
        case let .get(array, index):
            return GetExpr(
                array: array,
                index: index
            )
        default:
            return nil
        }
    }

    public var isPut: Bool {
        switch self {
        case .put: return true
        default: return false
        }
    }

    public struct PutExpr {
        public let array: Expr
        public let index: Expr
        public let value: Expr
    }

    public var asPut: PutExpr? {
        switch self {
        case let .put(array, index, value):
            return PutExpr(
                array: array,
                index: index,
                value: value
            )
        default:
            return nil
        }
    }
}

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
    case let (.fneg(lhs), .fneg(rhs)):
        return lhs == rhs
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
        if lhs.funcDef != rhs.funcDef { return false }
        if lhs.bind != rhs.bind { return false }
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
        case let .fneg(data):
            return combineHashes([9, data.hashValue])
        case let .fadd(data):
            return combineHashes([10, data.lhs.hashValue, data.rhs.hashValue])
        case let .fsub(data):
            return combineHashes([11, data.lhs.hashValue, data.rhs.hashValue])
        case let .fmul(data):
            return combineHashes([12, data.lhs.hashValue, data.rhs.hashValue])
        case let .fdiv(data):
            return combineHashes([13, data.lhs.hashValue, data.rhs.hashValue])
        case let .eq(data):
            return combineHashes([14, data.lhs.hashValue, data.rhs.hashValue])
        case let .le(data):
            return combineHashes([15, data.lhs.hashValue, data.rhs.hashValue])
        case let .if(data):
            return combineHashes([16, data.cond.hashValue, data.ifTrue.hashValue, data.ifFalse.hashValue])
        case let .let(data):
            return combineHashes([17, data.name.hashValue, data.bind.hashValue, data.body.hashValue])
        case let .var(data):
            return combineHashes([18, data.hashValue])
        case let .letRec(data):
            return combineHashes([19, data.funcDef.hashValue, data.bind.hashValue])
        case let .app(data):
            return combineHashes([20, data.function.hashValue, data.args.hashValue])
        case let .tuple(data):
            return combineHashes([21, data.hashValue])
        case let .letTuple(data):
            return combineHashes([22, data.vars.hashValue, data.binding.hashValue, data.body.hashValue])
        case let .array(data):
            return combineHashes([23, data.size.hashValue, data.element.hashValue])
        case let .get(data):
            return combineHashes([24, data.array.hashValue, data.index.hashValue])
        case let .put(data):
            return combineHashes([25, data.array.hashValue, data.index.hashValue, data.value.hashValue])
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
