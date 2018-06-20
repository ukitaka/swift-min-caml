// This file is automatically generated by Citron version 1.0.
//
// The parser class defined below conforms to the CitronParser protocol
// defined in CitronParser.swift. 
// 
// The authors of Citron disclaim copyright to the source code in this file.

// Preface


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

        func asIdentifier() -> String {
          switch self {
            case let .identifier(id):
             return id
            default:
             fatalError("\(self) is not identifier.")
          }
        }
    }


// Parser class

import CitronKit

class Parser: CitronParser {

    // Types

    typealias CitronSymbolCode = UInt8
    typealias CitronStateNumber = UInt8
    typealias CitronRuleNumber = UInt8

    enum CitronTokenCode: CitronSymbolCode {
      case ADD                            =   1
      case SUB                            =   2
      case MUL                            =   3
      case DIV                            =   4
      case INT                            =   5
      case FLOAT                          =   6
      case BOOL                           =   7
      case IDENTIFIER                     =   8
      case L_BR                           =   9
      case R_BR                           =  10
      case IF                             =  11
      case THEN                           =  12
      case ELSE                           =  13
      case LET                            =  14
      case REC                            =  15
      case EQUAL                          =  16
      case IN                             =  17
      case COMMA                          =  18
    }

    typealias CitronToken = Token

    enum CitronSymbol {
        case yyBaseOfStack
        case yy0(CitronToken)
        case yy4(Expr)
        case yy18([Var])
        case yy38(Var)
        case yy44([Expr])
        case yy56(Const)
    }

    typealias CitronResult = Expr

    // Counts

    let yyNumberOfSymbols: Int = 28
    let yyNumberOfStates: Int = 36

    // Action tables

    let yyLookaheadAction: [(CitronSymbolCode, CitronParsingAction)] = [
/*   0 */  ( 5, .SR( 7)), ( 6, .SR( 8)), ( 7, .SR( 9)), ( 8, .SR(10)), ( 9, .SH( 2)),
/*   5 */  ( 8, .SR(10)), (11, .SH(10)), (19, .ACCEPT),   (20, .SH(27)), (14, .SH(19)),
/*  10 */  (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)), (20, .SH(22)), (21, .RD(23)),
/*  15 */  (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)), (20, .SH(22)), (21, .SH(34)),
/*  20 */  (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)), ( 5, .SR( 7)), ( 6, .SR( 8)),
/*  25 */  ( 7, .SR( 9)), ( 8, .SR(10)), ( 9, .SH( 5)), ( 1, .SH(14)), ( 2, .SH(13)),
/*  30 */  ( 3, .SH(12)), ( 4, .SH(11)), ( 1, .SH(14)), ( 2, .SH(13)), ( 3, .SH(12)),
/*  35 */  ( 4, .SH(11)), ( 1, .SH(14)), ( 2, .SH(13)), ( 3, .SH(12)), ( 4, .SH(11)),
/*  40 */  ( 1, .SH(14)), ( 2, .SH(13)), ( 3, .SH(12)), ( 4, .SH(11)), (17, .SH( 3)),
/*  45 */  (10, .SR(15)), (24, .SH(17)), (25, .RD(11)), ( 8, .SR(10)), (18, .SH( 1)),
/*  50 */  (24, .SH(33)), ( 1, .SH(14)), ( 2, .SH(13)), ( 3, .SH(12)), ( 4, .SH(11)),
/*  55 */  (15, .SH(20)), (17, .SH( 6)), (24, .SH(18)), ( 1, .SH(14)), ( 2, .SH(13)),
/*  60 */  ( 3, .SH(12)), ( 4, .SH(11)), (28, .RD( 2)), (13, .SH( 8)), ( 0, .RD( 0)),
/*  65 */  ( 1, .SH(14)), ( 2, .SH(13)), ( 3, .SH(12)), ( 4, .SH(11)), (12, .SH( 9)),
/*  70 */  (24, .SH(17)), (25, .SH(35)), (20, .SH(28)), (28, .RD( 2)), (22, .RD( 5)),
/*  75 */  (23, .RD( 6)), (24, .SH(16)), (16, .SH( 4)), (10, .SR(25)), (20, .SH(21)),
/*  80 */  (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)), (28, .RD( 2)),
/*  85 */  (20, .SH(23)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)),
/*  90 */  (20, .SH(29)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)),
/*  95 */  (20, .SH(24)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)),
/* 100 */  (20, .SH(30)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)), (24, .SH(16)),
/* 105 */  (16, .SH( 7)), (20, .SH(25)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)),
/* 110 */  (24, .SH(16)), (20, .SH(26)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)),
/* 115 */  (24, .SH(16)), (20, .RD( 4)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)),
/* 120 */  (24, .SH(16)), (20, .RD( 3)), (28, .RD( 2)), (22, .RD( 5)), (23, .RD( 6)),
/* 125 */  (24, .SH(16)), (28, .RD( 2)), (20, .SH(31)), (28, .RD( 2)), (22, .RD( 5)),
/* 130 */  (23, .RD( 6)), (24, .SH(16)), (20, .SH(32)), (28, .RD( 2)), (22, .RD( 5)),
/* 135 */  (23, .RD( 6)), (24, .SH(16)), (23, .RD(13)), (24, .RD(14)), (28, .RD( 2)),
/* 140 */  (26, .SH(15)), (27, .RD(16)), (23, .RD(13)), (24, .RD(14)), (28, .RD( 2)),
/* 145 */  (26, .SH(15)), (27, .RD(21)), ( 1, .SH(14)), ( 2, .SH(13)), ( 3, .SH(12)),
/* 150 */  ( 4, .SH(11)), ( 3, .SH(12)), ( 4, .SH(11)),
    ]

    let yyShiftUseDefault: Int = 153
    let yyShiftOffsetMin: Int = -5
    let yyShiftOffsetMax: Int = 148
    let yyShiftOffset: [Int] = [
        /*     0 */    -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
        /*    10 */    -5,   -5,   -5,   -5,   -5,   18,   18,   -3,   -3,   40,
        /*    20 */    -3,   27,   31,   35,   39,   50,   57,   64,  146,  146,
        /*    30 */   146,  148,  148,   61,   68,   89,
    ]

    let yyReduceUseDefault: Int = -13
    let yyReduceOffsetMin: Int =   -12
    let yyReduceOffsetMax: Int =   119
    let yyReduceOffset: [Int] = [
        /*     0 */   -12,   -7,   -2,   52,   59,   65,   70,   75,   80,   86,
        /*    10 */    91,   96,  101,  107,  112,  114,  119,   22,   46,   26,
        /*    20 */    33,
    ]

    let yyDefaultAction: [CitronParsingAction] = [
  /*     0 */  .ERROR , .ERROR , .ERROR , .ERROR , .ERROR ,
  /*     5 */  .ERROR , .ERROR , .ERROR , .ERROR , .ERROR ,
  /*    10 */  .ERROR , .ERROR , .ERROR , .ERROR , .ERROR ,
  /*    15 */  .RD(17), .RD(22), .RD(12), .ERROR , .ERROR ,
  /*    20 */  .ERROR , .ERROR , .RD(24), .ERROR , .ERROR ,
  /*    25 */  .ERROR , .ERROR , .ERROR , .RD(20), .RD(19),
  /*    30 */  .RD(18), .RD( 2), .RD( 1), .ERROR , .ERROR ,
  /*    35 */  .ERROR ,
    ]

    // Fallback

    let yyHasFallback: Bool = false
    let yyFallback: [CitronSymbolCode] = []

    // Wildcard

    let yyWildcard: CitronSymbolCode? = nil

    // Rules

    let yyRuleInfo: [(lhs: CitronSymbolCode, nrhs: UInt)] = [
        (lhs: 19, nrhs: 1),
        (lhs: 22, nrhs: 3),
        (lhs: 22, nrhs: 3),
        (lhs: 22, nrhs: 3),
        (lhs: 22, nrhs: 3),
        (lhs: 20, nrhs: 1),
        (lhs: 20, nrhs: 1),
        (lhs: 23, nrhs: 1),
        (lhs: 23, nrhs: 1),
        (lhs: 23, nrhs: 1),
        (lhs: 24, nrhs: 1),
        (lhs: 25, nrhs: 2),
        (lhs: 25, nrhs: 1),
        (lhs: 26, nrhs: 1),
        (lhs: 26, nrhs: 1),
        (lhs: 26, nrhs: 3),
        (lhs: 27, nrhs: 2),
        (lhs: 27, nrhs: 1),
        (lhs: 20, nrhs: 6),
        (lhs: 20, nrhs: 8),
        (lhs: 20, nrhs: 6),
        (lhs: 20, nrhs: 2),
        (lhs: 20, nrhs: 1),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 1),
        (lhs: 20, nrhs: 3),
    ]

    // Stack

    var yyStack: [(stateOrRule: CitronStateOrRule , symbolCode: CitronSymbolCode, symbol: CitronSymbol)]  = [
        (stateOrRule: .state(0), symbolCode: 0, symbol: .yyBaseOfStack)
    ]
    var maxStackSize: Int? = nil
    // Tracing

    var isTracingEnabled: Bool = false
    let yySymbolName: [String] = [
        "$",                   "ADD",                 "SUB",                 "MUL",         
        "DIV",                 "INT",                 "FLOAT",               "BOOL",        
        "IDENTIFIER",          "L_BR",                "R_BR",                "IF",          
        "THEN",                "ELSE",                "LET",                 "REC",         
        "EQUAL",               "IN",                  "COMMA",               "root",        
        "expr",                "elements",            "arithOps",            "const",       
        "var",                 "vars",                "arg",                 "args",        
    ]
    let yyRuleText: [String] = [
        /*   0 */ "root ::= expr(a)",
        /*   1 */ "arithOps ::= expr(a) ADD expr(b)",
        /*   2 */ "arithOps ::= expr(a) SUB expr(b)",
        /*   3 */ "arithOps ::= expr(a) MUL expr(b)",
        /*   4 */ "arithOps ::= expr(a) DIV expr(b)",
        /*   5 */ "expr ::= arithOps(a)",
        /*   6 */ "expr ::= const(a)",
        /*   7 */ "const ::= INT(a)",
        /*   8 */ "const ::= FLOAT(a)",
        /*   9 */ "const ::= BOOL(a)",
        /*  10 */ "var ::= IDENTIFIER(a)",
        /*  11 */ "vars ::= var(a) vars(list)",
        /*  12 */ "vars ::= var(a)",
        /*  13 */ "arg ::= const(a)",
        /*  14 */ "arg ::= var(a)",
        /*  15 */ "arg ::= L_BR expr(a) R_BR",
        /*  16 */ "args ::= arg(a) args(list)",
        /*  17 */ "args ::= arg(a)",
        /*  18 */ "expr ::= IF expr(a) THEN expr(b) ELSE expr(c)",
        /*  19 */ "expr ::= LET REC var(a) vars(b) EQUAL expr(c) IN expr(d)",
        /*  20 */ "expr ::= LET var(a) EQUAL expr(b) IN expr(c)",
        /*  21 */ "expr ::= var(a) args(b)",
        /*  22 */ "expr ::= var(a)",
        /*  23 */ "elements ::= expr(a) COMMA elements(list)",
        /*  24 */ "elements ::= expr(a)",
        /*  25 */ "expr ::= L_BR elements(e) R_BR",
    ]

    // Function definitions

    func yyTokenToSymbol(_ token: CitronToken) -> CitronSymbol {
        return .yy0(token)
    }

    func yyInvokeCodeBlockForRule(ruleNumber: CitronRuleNumber) throws -> CitronSymbol {
        switch (ruleNumber) {
        case 0: /* root ::= expr(a) */
            func codeBlockForRule00(a: Expr) throws -> Expr {
    return a
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule00(a: a))
            }
        case 1: /* arithOps ::= expr(a) ADD expr(b) */
            func codeBlockForRule01(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .add, args: [a, b])
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy4(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule01(a: a, b: b))
            }
        case 2: /* arithOps ::= expr(a) SUB expr(b) */
            func codeBlockForRule02(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .sub, args: [a, b])
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy4(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule02(a: a, b: b))
            }
        case 3: /* arithOps ::= expr(a) MUL expr(b) */
            func codeBlockForRule03(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .mul, args: [a, b])
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy4(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule03(a: a, b: b))
            }
        case 4: /* arithOps ::= expr(a) DIV expr(b) */
            func codeBlockForRule04(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .div, args: [a, b])
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy4(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule04(a: a, b: b))
            }
        case 5: /* expr ::= arithOps(a) */
            func codeBlockForRule05(a: Expr) throws -> Expr {
    return a
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule05(a: a))
            }
        case 6: /* expr ::= const(a) */
            func codeBlockForRule06(a: Const) throws -> Expr {
    return .const(const: a)
 }
            if case .yy56(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule06(a: a))
            }
        case 7: /* const ::= INT(a) */
            func codeBlockForRule07(a: Token) throws -> Const {
    return .integer(a.asInt())
 }
            if case .yy0(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy56(try codeBlockForRule07(a: a))
            }
        case 8: /* const ::= FLOAT(a) */
            func codeBlockForRule08(a: Token) throws -> Const {
    return .float(a.asFloat())
 }
            if case .yy0(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy56(try codeBlockForRule08(a: a))
            }
        case 9: /* const ::= BOOL(a) */
            func codeBlockForRule09(a: Token) throws -> Const {
    return .bool(a.asBool())
 }
            if case .yy0(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy56(try codeBlockForRule09(a: a))
            }
        case 10: /* var ::= IDENTIFIER(a) */
            func codeBlockForRule10(a: Token) throws -> Var {
    return Var(rawValue: a.asIdentifier())
 }
            if case .yy0(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy38(try codeBlockForRule10(a: a))
            }
        case 11: /* vars ::= var(a) vars(list) */
            func codeBlockForRule11(a: Var, list: [Var]) throws -> [Var] {
    return [a] + list
 }
            if case .yy38(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy18(let list) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy18(try codeBlockForRule11(a: a, list: list))
            }
        case 12: /* vars ::= var(a) */
            func codeBlockForRule12(a: Var) throws -> [Var] {
    return [a]
 }
            if case .yy38(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy18(try codeBlockForRule12(a: a))
            }
        case 13: /* arg ::= const(a) */
            func codeBlockForRule13(a: Const) throws -> Expr {
    return .const(const: a)
 }
            if case .yy56(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule13(a: a))
            }
        case 14: /* arg ::= var(a) */
            func codeBlockForRule14(a: Var) throws -> Expr {
    return .var(variable: a)
 }
            if case .yy38(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule14(a: a))
            }
        case 15: /* arg ::= L_BR expr(a) R_BR */
            func codeBlockForRule15(a: Expr) throws -> Expr {
    return a
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy4(try codeBlockForRule15(a: a))
            }
        case 16: /* args ::= arg(a) args(list) */
            func codeBlockForRule16(a: Expr, list: [Expr]) throws -> [Expr] {
    return [a] + list
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy44(let list) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy44(try codeBlockForRule16(a: a, list: list))
            }
        case 17: /* args ::= arg(a) */
            func codeBlockForRule17(a: Expr) throws -> [Expr] {
    return [a]
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy44(try codeBlockForRule17(a: a))
            }
        case 18: /* expr ::= IF expr(a) THEN expr(b) ELSE expr(c) */
            func codeBlockForRule18(a: Expr, b: Expr, c: Expr) throws -> Expr {
    return .if(cond: a, ifTrue:b, ifFalse:c)
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 4),
               case .yy4(let b) = yySymbolOnStack(distanceFromTop: 2),
               case .yy4(let c) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule18(a: a, b: b, c: c))
            }
        case 19: /* expr ::= LET REC var(a) vars(b) EQUAL expr(c) IN expr(d) */
            func codeBlockForRule19(a: Var, b: [Var], c: Expr, d: Expr) throws -> Expr {
    return .letRec(name: a, args: b, bind: c, body: d)
 }
            if case .yy38(let a) = yySymbolOnStack(distanceFromTop: 5),
               case .yy18(let b) = yySymbolOnStack(distanceFromTop: 4),
               case .yy4(let c) = yySymbolOnStack(distanceFromTop: 2),
               case .yy4(let d) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule19(a: a, b: b, c: c, d: d))
            }
        case 20: /* expr ::= LET var(a) EQUAL expr(b) IN expr(c) */
            func codeBlockForRule20(a: Var, b: Expr, c: Expr) throws -> Expr {
    return .let(varName: a, bind: b, body: c)
 }
            if case .yy38(let a) = yySymbolOnStack(distanceFromTop: 4),
               case .yy4(let b) = yySymbolOnStack(distanceFromTop: 2),
               case .yy4(let c) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule20(a: a, b: b, c: c))
            }
        case 21: /* expr ::= var(a) args(b) */
            func codeBlockForRule21(a: Var, b: [Expr]) throws -> Expr {
    return .apply(function: a, args: b)
 }
            if case .yy38(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy44(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule21(a: a, b: b))
            }
        case 22: /* expr ::= var(a) */
            func codeBlockForRule22(a: Var) throws -> Expr {
    return .var(variable: a)
 }
            if case .yy38(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy4(try codeBlockForRule22(a: a))
            }
        case 23: /* elements ::= expr(a) COMMA elements(list) */
            func codeBlockForRule23(a: Expr, list: [Expr]) throws -> [Expr] {
    return [a] + list
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy44(let list) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy44(try codeBlockForRule23(a: a, list: list))
            }
        case 24: /* elements ::= expr(a) */
            func codeBlockForRule24(a: Expr) throws -> [Expr] {
    return [a]
 }
            if case .yy4(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy44(try codeBlockForRule24(a: a))
            }
        case 25: /* expr ::= L_BR elements(e) R_BR */
            func codeBlockForRule25(e: [Expr]) throws -> Expr {
    return .tuple(elements: e)
 }
            if case .yy44(let e) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy4(try codeBlockForRule25(e: e))
            }
        default:
            fatalError("Can't invoke code block for rule number \(ruleNumber) - no such rule")
        }
        fatalError("Can't resolve types correctly for invoking code block for rule number \(ruleNumber)")
    }

    private func yySymbolOnStack(distanceFromTop: Int) -> CitronSymbol {
        assert(yyStack.count > distanceFromTop)
        return yyStack[yyStack.count - 1 - distanceFromTop].symbol
    }

    func yyUnwrapResultFromSymbol(_ symbol: CitronSymbol) -> CitronResult {
        if case .yy4(let result) = symbol {
            return result
        } else {
            fatalError("Unexpected mismatch in result type")
        }
    }

}

