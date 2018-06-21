// Generated using Sourcery 0.11.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



public extension ArithOps {
  public var isAdd: Bool {
    switch self {
      case .add: return true
      default: return false
    }
  }



  public var isSub: Bool {
    switch self {
      case .sub: return true
      default: return false
    }
  }



  public var isMul: Bool {
    switch self {
      case .mul: return true
      default: return false
    }
  }



  public var isDiv: Bool {
    switch self {
      case .div: return true
      default: return false
    }
  }



}
public extension Const {
  public var isInteger: Bool {
    switch self {
      case .integer: return true
      default: return false
    }
  }

  public var asInteger: Int? {
    switch self {
    case let .integer(integer):
      return integer
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

}
public extension Expr {
  public var isConst: Bool {
    switch self {
      case .const: return true
      default: return false
    }
  }

  public var asConst: Const? {
    switch self {
    case let .const(const):
      return const
    default:
      return nil
    }
  }

  public var isArithOps: Bool {
    switch self {
      case .arithOps: return true
      default: return false
    }
  }

  public struct ArithOpsExpr {
    public let ops: ArithOps
    public let args: [Expr]
  }

  public var asArithOps: ArithOpsExpr? {
    switch self {
    case let .arithOps(ops, args):
      return ArithOpsExpr (
        ops: ops,
        args: args
      )
    default:
      return nil
    }
  }

  public var isIf: Bool {
    switch self {
      case .`if`: return true
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
    case let .`if`(cond, ifTrue, ifFalse):
      return IfExpr (
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
      case .`let`: return true
      default: return false
    }
  }

  public struct LetExpr {
    public let varName: Var
    public let bind: Expr
    public let body: Expr
  }

  public var asLet: LetExpr? {
    switch self {
    case let .`let`(varName, bind, body):
      return LetExpr (
        varName: varName,
        bind: bind,
        body: body
      )
    default:
      return nil
    }
  }

  public var isVar: Bool {
    switch self {
      case .`var`: return true
      default: return false
    }
  }

  public var asVar: Var? {
    switch self {
    case let .`var`(variable):
      return variable
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
    public let name: Var
    public let args: [Var]
    public let bind: Expr
    public let body: Expr
  }

  public var asLetRec: LetRecExpr? {
    switch self {
    case let .letRec(name, args, bind, body):
      return LetRecExpr (
        name: name,
        args: args,
        bind: bind,
        body: body
      )
    default:
      return nil
    }
  }

  public var isApply: Bool {
    switch self {
      case .apply: return true
      default: return false
    }
  }

  public struct ApplyExpr {
    public let function: Var
    public let args: [Expr]
  }

  public var asApply: ApplyExpr? {
    switch self {
    case let .apply(function, args):
      return ApplyExpr (
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

  public var isReadTuple: Bool {
    switch self {
      case .readTuple: return true
      default: return false
    }
  }

  public struct ReadTupleExpr {
    public let vars: [Var]
    public let bindings: Expr
    public let body: Expr
  }

  public var asReadTuple: ReadTupleExpr? {
    switch self {
    case let .readTuple(vars, bindings, body):
      return ReadTupleExpr (
        vars: vars,
        bindings: bindings,
        body: body
      )
    default:
      return nil
    }
  }

  public var isCreateArray: Bool {
    switch self {
      case .createArray: return true
      default: return false
    }
  }

  public struct CreateArrayExpr {
    public let size: Expr
    public let element: Expr
  }

  public var asCreateArray: CreateArrayExpr? {
    switch self {
    case let .createArray(size, element):
      return CreateArrayExpr (
        size: size,
        element: element
      )
    default:
      return nil
    }
  }

  public var isReadArray: Bool {
    switch self {
      case .readArray: return true
      default: return false
    }
  }

  public struct ReadArrayExpr {
    public let array: Expr
    public let index: Expr
  }

  public var asReadArray: ReadArrayExpr? {
    switch self {
    case let .readArray(array, index):
      return ReadArrayExpr (
        array: array,
        index: index
      )
    default:
      return nil
    }
  }

  public var isWriteArray: Bool {
    switch self {
      case .writeArray: return true
      default: return false
    }
  }

  public struct WriteArrayExpr {
    public let array: Expr
    public let index: Expr
    public let value: Expr
  }

  public var asWriteArray: WriteArrayExpr? {
    switch self {
    case let .writeArray(array, index, value):
      return WriteArrayExpr (
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
      case .`func`: return true
      default: return false
    }
  }

  public struct FuncType {
    public let args: [Type]
    public let ret: Type
  }

  public var asFunc: FuncType? {
    switch self {
    case let .`func`(args, ret):
      return FuncType (
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
// MARK: - Const AutoEquatable
extension Const: Equatable {}
public func == (lhs: Const, rhs: Const) -> Bool {
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
public func == (lhs: Expr, rhs: Expr) -> Bool {
    switch (lhs, rhs) {
    case (.const(let lhs), .const(let rhs)):
        return lhs == rhs
    case (.arithOps(let lhs), .arithOps(let rhs)):
        if lhs.ops != rhs.ops { return false }
        if lhs.args != rhs.args { return false }
        return true
    case (.`if`(let lhs), .`if`(let rhs)):
        if lhs.cond != rhs.cond { return false }
        if lhs.ifTrue != rhs.ifTrue { return false }
        if lhs.ifFalse != rhs.ifFalse { return false }
        return true
    case (.`let`(let lhs), .`let`(let rhs)):
        if lhs.varName != rhs.varName { return false }
        if lhs.bind != rhs.bind { return false }
        if lhs.body != rhs.body { return false }
        return true
    case (.`var`(let lhs), .`var`(let rhs)):
        return lhs == rhs
    case (.letRec(let lhs), .letRec(let rhs)):
        if lhs.name != rhs.name { return false }
        if lhs.args != rhs.args { return false }
        if lhs.bind != rhs.bind { return false }
        if lhs.body != rhs.body { return false }
        return true
    case (.apply(let lhs), .apply(let rhs)):
        if lhs.function != rhs.function { return false }
        if lhs.args != rhs.args { return false }
        return true
    case (.tuple(let lhs), .tuple(let rhs)):
        return lhs == rhs
    case (.readTuple(let lhs), .readTuple(let rhs)):
        if lhs.vars != rhs.vars { return false }
        if lhs.bindings != rhs.bindings { return false }
        if lhs.body != rhs.body { return false }
        return true
    case (.createArray(let lhs), .createArray(let rhs)):
        if lhs.size != rhs.size { return false }
        if lhs.element != rhs.element { return false }
        return true
    case (.readArray(let lhs), .readArray(let rhs)):
        if lhs.array != rhs.array { return false }
        if lhs.index != rhs.index { return false }
        return true
    case (.writeArray(let lhs), .writeArray(let rhs)):
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
    case (.int, .int):
        return true
    case (.float, .float):
        return true
    case (.bool, .bool):
        return true
    case (.`func`(let lhs), .`func`(let rhs)):
        if lhs.args != rhs.args { return false }
        if lhs.ret != rhs.ret { return false }
        return true
    case (.tuple(let lhs), .tuple(let rhs)):
        return lhs == rhs
    case (.array(let lhs), .array(let rhs)):
        return lhs == rhs
    case (.typeVar(let lhs), .typeVar(let rhs)):
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
    public var hashValue: Int {

        return combineHashes([
            0])
    }
}

// MARK: - AutoHashable for Enums

// MARK: - Const AutoHashable
extension Const: Hashable {
    public var hashValue: Int {
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
    public var hashValue: Int {
        switch self {
        case .const(let data):
            return combineHashes([1, data.hashValue])
        case .arithOps(let data):
            return combineHashes([2, data.ops.hashValue, data.args.hashValue])
        case .`if`(let data):
            return combineHashes([3, data.cond.hashValue, data.ifTrue.hashValue, data.ifFalse.hashValue])
        case .`let`(let data):
            return combineHashes([4, data.varName.hashValue, data.bind.hashValue, data.body.hashValue])
        case .`var`(let data):
            return combineHashes([5, data.hashValue])
        case .letRec(let data):
            return combineHashes([6, data.name.hashValue, data.args.hashValue, data.bind.hashValue, data.body.hashValue])
        case .apply(let data):
            return combineHashes([7, data.function.hashValue, data.args.hashValue])
        case .tuple(let data):
            return combineHashes([8, data.hashValue])
        case .readTuple(let data):
            return combineHashes([9, data.vars.hashValue, data.bindings.hashValue, data.body.hashValue])
        case .createArray(let data):
            return combineHashes([10, data.size.hashValue, data.element.hashValue])
        case .readArray(let data):
            return combineHashes([11, data.array.hashValue, data.index.hashValue])
        case .writeArray(let data):
            return combineHashes([12, data.array.hashValue, data.index.hashValue, data.value.hashValue])
        }
    }
}

// MARK: - Type AutoHashable
extension Type: Hashable {
    public var hashValue: Int {
        switch self {
        case .int:
            return 1.hashValue
        case .float:
            return 2.hashValue
        case .bool:
            return 3.hashValue
        case .`func`(let data):
            return combineHashes([4, data.args.hashValue, data.ret.hashValue])
        case .tuple(let data):
            return combineHashes([5, data.hashValue])
        case .array(let data):
            return combineHashes([6, data.hashValue])
        case .typeVar(let data):
            return combineHashes([7, data.hashValue])
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


public indirect enum TypedExpr {
    case const(const: Const, type: Type)
    case arithOps(ops: ArithOps, args: [TypedExpr], type: Type)
    case `if`(cond: TypedExpr, ifTrue: TypedExpr, ifFalse: TypedExpr, type: Type)
    case `let`(varName: Var, bind: TypedExpr, body: TypedExpr, type: Type)
    case `var`(variable: Var, type: Type)
    case letRec(name: Var, args: [Var], bind: TypedExpr, body: TypedExpr, type: Type)
    case apply(function: Var, args: [TypedExpr], type: Type)
    case tuple(elements: [TypedExpr], type: Type)
    case readTuple(vars: [Var], bindings: TypedExpr, body: TypedExpr, type: Type)
    case createArray(size: TypedExpr, element: TypedExpr, type: Type)
    case readArray(array: TypedExpr, index: TypedExpr, type: Type)
    case writeArray(array: TypedExpr, index: TypedExpr, value: TypedExpr, type: Type)
}

public extension TypedExpr {
    var type: Type {
        switch self {
            case let .const(_, type):
                return type
            case let .arithOps(_, _, type):
                return type
            case let .`if`(_, _, _, type):
                return type
            case let .`let`(_, _, _, type):
                return type
            case let .`var`(_, type):
                return type
            case let .letRec(_, _, _, _, type):
                return type
            case let .apply(_, _, type):
                return type
            case let .tuple(_, type):
                return type
            case let .readTuple(_, _, _, type):
                return type
            case let .createArray(_, _, type):
                return type
            case let .readArray(_, _, type):
                return type
            case let .writeArray(_, _, _, type):
                return type
        }
    }

    func untyped() -> Expr {
        switch self {
            case let .const(const, _):
                return .const(const:  const)
            case let .arithOps(ops, args, _):
                return .arithOps(ops:  ops, args: args.map { $0.untyped() })
            case let .`if`(cond, ifTrue, ifFalse, _):
                return .`if`(cond: cond.untyped(), ifTrue: ifTrue.untyped(), ifFalse: ifFalse.untyped())
            case let .`let`(varName, bind, body, _):
                return .`let`(varName:  varName, bind: bind.untyped(), body: body.untyped())
            case let .`var`(variable, _):
                return .`var`(variable:  variable)
            case let .letRec(name, args, bind, body, _):
                return .letRec(name:  name, args:  args, bind: bind.untyped(), body: body.untyped())
            case let .apply(function, args, _):
                return .apply(function:  function, args: args.map { $0.untyped() })
            case let .tuple(elements, _):
                return .tuple(elements: elements.map { $0.untyped() })
            case let .readTuple(vars, bindings, body, _):
                return .readTuple(vars:  vars, bindings: bindings.untyped(), body: body.untyped())
            case let .createArray(size, element, _):
                return .createArray(size: size.untyped(), element: element.untyped())
            case let .readArray(array, index, _):
                return .readArray(array: array.untyped(), index: index.untyped())
            case let .writeArray(array, index, value, _):
                return .writeArray(array: array.untyped(), index: index.untyped(), value: value.untyped())
        }
    }
}

public extension Expr {
    func constraintTyping() -> TypedExpr {
        switch self {
        case let .const(const):
            return .const(const: const, type: Typing.type(const: const))
            case let .arithOps(ops, args):
                return .arithOps(ops: ops, args: args.map { $0.constraintTyping() }, type: Type.newTypeVar())
            case let .`if`(cond, ifTrue, ifFalse):
                return .`if`(cond: cond.constraintTyping(), ifTrue: ifTrue.constraintTyping(), ifFalse: ifFalse.constraintTyping(), type: Type.newTypeVar())
            case let .`let`(varName, bind, body):
                return .`let`(varName: varName, bind: bind.constraintTyping(), body: body.constraintTyping(), type: Type.newTypeVar())
            case let .`var`(variable):
                return .`var`(variable: variable, type: Type.newTypeVar())
            case let .letRec(name, args, bind, body):
                return .letRec(name: name, args: args, bind: bind.constraintTyping(), body: body.constraintTyping(), type: Type.newTypeVar())
            case let .apply(function, args):
                return .apply(function: function, args: args.map { $0.constraintTyping() }, type: Type.newTypeVar())
            case let .tuple(elements):
                return .tuple(elements: elements.map { $0.constraintTyping() }, type: Type.newTypeVar())
            case let .readTuple(vars, bindings, body):
                return .readTuple(vars: vars, bindings: bindings.constraintTyping(), body: body.constraintTyping(), type: Type.newTypeVar())
            case let .createArray(size, element):
                return .createArray(size: size.constraintTyping(), element: element.constraintTyping(), type: Type.newTypeVar())
            case let .readArray(array, index):
                return .readArray(array: array.constraintTyping(), index: index.constraintTyping(), type: Type.newTypeVar())
            case let .writeArray(array, index, value):
                return .writeArray(array: array.constraintTyping(), index: index.constraintTyping(), value: value.constraintTyping(), type: Type.newTypeVar())
        }
    }
}


