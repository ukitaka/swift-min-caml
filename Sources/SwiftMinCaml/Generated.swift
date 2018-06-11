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
        }
    }
}
