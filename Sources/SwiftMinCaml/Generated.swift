// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


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
// MARK: - Const AutoEquatable
extension Const: Equatable {}
func == (lhs: Const, rhs: Const) -> Bool {
    switch (lhs, rhs) {
    case (.integer(let lhs), .integer(let rhs)):
        return lhs == rhs
    case (.float(let lhs), .float(let rhs)):
        return lhs == rhs
    case (.bool(let lhs), .bool(let rhs)):
        return lhs == rhs
    default: return false
    }
}
// MARK: - Expr AutoEquatable
extension Expr: Equatable {}
func == (lhs: Expr, rhs: Expr) -> Bool {
    switch (lhs, rhs) {
    case (.const(let lhs), .const(let rhs)):
        return lhs == rhs
    case (.arithOps(let lhs), .arithOps(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        return true
    case (.`if`(let lhs), .`if`(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        if lhs.2 != rhs.2 { return false }
        return true
    case (.`let`(let lhs), .`let`(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        if lhs.2 != rhs.2 { return false }
        return true
    case (.`var`(let lhs), .`var`(let rhs)):
        return lhs == rhs
    case (.letRec(let lhs), .letRec(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        if lhs.2 != rhs.2 { return false }
        if lhs.3 != rhs.3 { return false }
        return true
    case (.apply(let lhs), .apply(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        return true
    case (.tuple(let lhs), .tuple(let rhs)):
        return lhs == rhs
    case (.readTuple(let lhs), .readTuple(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        if lhs.2 != rhs.2 { return false }
        return true
    case (.createArray(let lhs), .createArray(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        return true
    case (.readArray(let lhs), .readArray(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        return true
    case (.writeArray(let lhs), .writeArray(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        if lhs.2 != rhs.2 { return false }
        return true
    default: return false
    }
}
// MARK: - Type AutoEquatable
extension Type: Equatable {}
func == (lhs: Type, rhs: Type) -> Bool {
    switch (lhs, rhs) {
    case (.int, .int):
        return true
    case (.float, .float):
        return true
    case (.bool, .bool):
        return true
    case (.`func`(let lhs), .`func`(let rhs)):
        if lhs.0 != rhs.0 { return false }
        if lhs.1 != rhs.1 { return false }
        return true
    case (.tuple(let lhs), .tuple(let rhs)):
        return lhs == rhs
    case (.array(let lhs), .array(let rhs)):
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
        let magic: UInt = 0x9e3779b97f4a7c15
    #elseif arch(i386) || arch(arm)
        let magic: UInt = 0x9e3779b9
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
// MARK: - Node AutoHashable
extension Node {
    internal var hashValue: Int {

        return combineHashes([
            0])
    }
}

// MARK: - AutoHashable for Enums

// MARK: - Const AutoHashable
extension Const: Hashable {
    internal var hashValue: Int {
        switch self {
        case .integer(let data):
            return combineHashes([1, data.hashValue])
        case .float(let data):
            return combineHashes([2, data.hashValue])
        case .bool(let data):
            return combineHashes([3, data.hashValue])
        }
    }
}

// MARK: - Expr AutoHashable
extension Expr: Hashable {
    internal var hashValue: Int {
        switch self {
        case .const(let data):
            return combineHashes([1, data.hashValue])
        case .arithOps(let data):
            return combineHashes([2, data.0.hashValue, data.1.hashValue])
        case .`if`(let data):
            return combineHashes([3, data.0.hashValue, data.1.hashValue, data.2.hashValue])
        case .`let`(let data):
            return combineHashes([4, data.0.hashValue, data.1.hashValue, data.2.hashValue])
        case .`var`(let data):
            return combineHashes([5, data.hashValue])
        case .letRec(let data):
            return combineHashes([6, data.0.hashValue, data.1.hashValue, data.2.hashValue, data.3.hashValue])
        case .apply(let data):
            return combineHashes([7, data.0.hashValue, data.1.hashValue])
        case .tuple(let data):
            return combineHashes([8, data.hashValue])
        case .readTuple(let data):
            return combineHashes([9, data.0.hashValue, data.1.hashValue, data.2.hashValue])
        case .createArray(let data):
            return combineHashes([10, data.0.hashValue, data.1.hashValue])
        case .readArray(let data):
            return combineHashes([11, data.0.hashValue, data.1.hashValue])
        case .writeArray(let data):
            return combineHashes([12, data.0.hashValue, data.1.hashValue, data.2.hashValue])
        }
    }
}

// MARK: - Type AutoHashable
extension Type: Hashable {
    internal var hashValue: Int {
        switch self {
        case .int:
            return 1.hashValue
        case .float:
            return 2.hashValue
        case .bool:
            return 3.hashValue
        case .`func`(let data):
            return combineHashes([4, data.0.hashValue, data.1.hashValue])
        case .tuple(let data):
            return combineHashes([5, data.hashValue])
        case .array(let data):
            return combineHashes([6, data.hashValue])
        }
    }
}

// MARK: - AutoHashable for Array
extension Array: Hashable where Element: Hashable {
    public var hashValue: Int {
        return self.reduce(5381) {
            ($0 << 5) &+ $0 &+ $1.hashValue
        }
    }
}
