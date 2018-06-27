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
      case ARRAY_CREATE                   =  18
      case DOT                            =  19
      case LEFT_ARROW                     =  20
      case COMMA                          =  21
    }

    typealias CitronToken = Token

    enum CitronSymbol {
        case yyBaseOfStack
        case yy0(CitronToken)
        case yy26([Var])
        case yy28(Expr)
        case yy29([Expr])
        case yy46(Var)
        case yy56(Const)
    }

    typealias CitronResult = Expr

    // Counts

    let yyNumberOfSymbols: Int = 32
    let yyNumberOfStates: Int = 56

    // Action tables

    let yyLookaheadAction: [(CitronSymbolCode, CitronParsingAction)] = [
/*   0 */  ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)), ( 5, .SR( 7)),
/*   5 */  ( 6, .SR( 8)), ( 7, .SR( 9)), ( 8, .SR(10)), ( 9, .SH( 2)), ( 8, .SR(10)),
/*  10 */  (11, .SH(14)), (23, .SH(31)), (24, .RD(27)), (14, .SH(27)), (26, .RD( 5)),
/*  15 */  (27, .RD( 6)), (28, .SH(22)), (18, .SH( 9)), (19, .SH(53)), ( 5, .SR( 7)),
/*  20 */  ( 6, .SR( 8)), ( 7, .SR( 9)), ( 8, .SR(10)), ( 9, .SH( 2)), (28, .SH(46)),
/*  25 */  (11, .SH(14)), (23, .SH(31)), (24, .SH(50)), (14, .SH(27)), (26, .RD( 5)),
/*  30 */  (27, .RD( 6)), (28, .SH(22)), (18, .SH( 9)), (28, .SH(26)), ( 1, .SH(20)),
/*  35 */  ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)), ( 1, .SH(20)), ( 2, .SH(19)),
/*  40 */  ( 3, .SH(18)), ( 4, .SH(17)), ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)),
/*  45 */  ( 4, .SH(17)), ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)),
/*  50 */  (17, .SH( 4)), (16, .SH( 5)), (19, .SH(53)), (21, .SH(23)), (17, .SH( 6)),
/*  55 */  (10, .SR(15)), (19, .SH(53)), ( 9, .SH(16)), ( 8, .SR(10)), ( 9, .SH(24)),
/*  60 */  (19, .SH(53)), (19, .SH(53)), (21, .SH( 1)), (16, .SH( 7)), (19, .SH(53)),
/*  65 */  (15, .SH(28)), ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)),
/*  70 */  (16, .SH(11)), ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)),
/*  75 */  ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)), (28, .SH(25)),
/*  80 */  (29, .RD(11)), (20, .SH(15)), (17, .SH(10)), (13, .SH(12)), (19, .SH(53)),
/*  85 */  (25, .RD(29)), (12, .SH(13)), (10, .SH(48)), (28, .SH(47)), (19, .SH(53)),
/*  90 */  (10, .SR(31)), (25, .SH(49)), (32, .RD( 2)), (19, .SH(53)), (28, .SH(47)),
/*  95 */  ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)), ( 0, .RD( 0)),
/* 100 */  ( 1, .SH(20)), ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)), (10, .SH(52)),
/* 105 */  (22, .ACCEPT), (23, .SH(37)), (28, .SH(25)), (29, .SH(51)), (26, .RD( 5)),
/* 110 */  (27, .RD( 6)), (28, .SH(22)), (32, .RD( 2)), (19, .SH(53)), (32, .RD( 2)),
/* 115 */  (32, .RD( 2)), (32, .RD( 2)), (32, .RD( 2)), (19, .SH(53)), ( 5, .SR( 7)),
/* 120 */  ( 6, .SR( 8)), ( 7, .SR( 9)), ( 8, .SR(10)), ( 9, .SH( 8)), ( 1, .SH(20)),
/* 125 */  ( 2, .SH(19)), ( 3, .SH(18)), ( 4, .SH(17)), (23, .SH(40)), (32, .RD( 2)),
/* 130 */  (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (23, .SH(38)),
/* 135 */  (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)),
/* 140 */  (32, .RD( 2)), (32, .RD( 2)), (19, .SH(53)), (23, .SH(29)), (32, .RD( 2)),
/* 145 */  (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (23, .SH(39)),
/* 150 */  (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)),
/* 155 */  (23, .SH(30)), (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)),
/* 160 */  (28, .SH(22)), (23, .SH(32)), (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)),
/* 165 */  (27, .RD( 6)), (28, .SH(22)), (23, .SH( 3)), (32, .RD( 2)), (32, .RD( 2)),
/* 170 */  (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (23, .SH(41)), (32, .RD( 2)),
/* 175 */  (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (23, .SH(33)),
/* 180 */  (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)),
/* 185 */  (23, .SH(42)), (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)),
/* 190 */  (28, .SH(22)), (23, .SH(34)), (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)),
/* 195 */  (27, .RD( 6)), (28, .SH(22)), (23, .SH(35)), (32, .RD( 2)), (32, .RD( 2)),
/* 200 */  (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (23, .SH(43)), (32, .RD( 2)),
/* 205 */  (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (23, .SH(36)),
/* 210 */  (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)),
/* 215 */  (23, .SH(54)), (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)),
/* 220 */  (28, .SH(22)), (23, .SH(55)), (32, .RD( 2)), (32, .RD( 2)), (26, .RD( 5)),
/* 225 */  (27, .RD( 6)), (28, .SH(22)), (23, .SH(44)), (32, .RD( 2)), (32, .RD( 2)),
/* 230 */  (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (23, .SH(45)), (32, .RD( 2)),
/* 235 */  (32, .RD( 2)), (26, .RD( 5)), (27, .RD( 6)), (28, .SH(22)), (32, .RD( 2)),
/* 240 */  (27, .RD(13)), (28, .RD(14)), (32, .RD( 2)), (30, .SH(21)), (31, .RD(16)),
/* 245 */  (32, .RD( 2)), (27, .RD(13)), (28, .RD(14)), (32, .RD( 2)), (30, .SH(21)),
/* 250 */  (31, .RD(25)), ( 3, .SH(18)), ( 4, .SH(17)), (32, .RD( 2)), (32, .RD( 2)),
/* 255 */  (32, .RD( 2)), (32, .RD( 2)), (32, .RD( 2)), (32, .RD( 2)), (32, .RD( 2)),
/* 260 */  (32, .RD( 2)), (32, .RD( 2)), (32, .RD( 2)), (32, .RD( 2)), (32, .RD( 2)),
/* 265 */  (32, .RD( 2)), (32, .RD( 2)), (19, .SH(53))
    ]

    let yyShiftUseDefault: Int = 268
    let yyShiftOffsetMin: Int = -1
    let yyShiftOffsetMax: Int = 248
    let yyShiftOffset: [Int] = [
        /*     0 */    14, 14, 14, -1, 14, 14, 14, 14, 14, 14,
        /*    10 */    14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
        /*    20 */    14, 114, 114, 1, 1, 1, 1, 50, 1, 33,
        /*    30 */    37, 41, 45, 65, 70, 74, 94, 99, 123, 123,
        /*    40 */   123, 123, 123, 123, 248, 248, 35, 32, 47, 77,
        /*    50 */    80, 54, 61, 48, 42, 42
    ]

    let yyReduceUseDefault: Int = -13
    let yyReduceOffsetMin: Int =   -12
    let yyReduceOffsetMax: Int =   219
    let yyReduceOffset: [Int] = [
        /*     0 */    83, -12, 3, 105, 111, 120, 126, 132, 138, 144,
        /*    10 */   150, 156, 162, 168, 174, 180, 186, 192, 198, 204,
        /*    20 */   210, 213, 219, 60, 66, 51, 79, -4, 5
    ]

    let yyDefaultAction: [CitronParsingAction] = [
  /*     0 */  .ERROR, .ERROR, .ERROR, .ERROR, .ERROR ,
  /*     5 */  .ERROR, .ERROR, .ERROR, .ERROR, .ERROR ,
  /*    10 */  .ERROR, .ERROR, .ERROR, .ERROR, .ERROR ,
  /*    15 */  .ERROR, .ERROR, .ERROR, .ERROR, .ERROR ,
  /*    20 */  .ERROR, .RD(17), .RD(26), .ERROR, .ERROR ,
  /*    25 */  .RD(12), .ERROR, .ERROR, .ERROR, .ERROR ,
  /*    30 */  .ERROR, .RD(28), .ERROR, .ERROR, .ERROR ,
  /*    35 */  .ERROR, .ERROR, .ERROR, .RD(21), .RD(20),
  /*    40 */  .RD(22), .RD(19), .RD(18), .RD(23), .RD( 2),
  /*    45 */  .RD( 1), .ERROR, .RD(30), .ERROR, .ERROR ,
  /*    50 */  .ERROR, .ERROR, .RD(24), .ERROR, .RD( 4),
  /*    55 */  .RD( 3)
    ]

    // Fallback

    let yyHasFallback: Bool = false
    let yyFallback: [CitronSymbolCode] = []

    // Wildcard

    let yyWildcard: CitronSymbolCode? = nil

    // Rules

    let yyRuleInfo: [(lhs: CitronSymbolCode, nrhs: UInt)] = [
        (lhs: 22, nrhs: 1),
        (lhs: 26, nrhs: 3),
        (lhs: 26, nrhs: 3),
        (lhs: 26, nrhs: 3),
        (lhs: 26, nrhs: 3),
        (lhs: 23, nrhs: 1),
        (lhs: 23, nrhs: 1),
        (lhs: 27, nrhs: 1),
        (lhs: 27, nrhs: 1),
        (lhs: 27, nrhs: 1),
        (lhs: 28, nrhs: 1),
        (lhs: 29, nrhs: 2),
        (lhs: 29, nrhs: 1),
        (lhs: 30, nrhs: 1),
        (lhs: 30, nrhs: 1),
        (lhs: 30, nrhs: 3),
        (lhs: 31, nrhs: 2),
        (lhs: 31, nrhs: 1),
        (lhs: 23, nrhs: 6),
        (lhs: 23, nrhs: 8),
        (lhs: 23, nrhs: 8),
        (lhs: 23, nrhs: 6),
        (lhs: 23, nrhs: 3),
        (lhs: 23, nrhs: 7),
        (lhs: 23, nrhs: 5),
        (lhs: 23, nrhs: 2),
        (lhs: 23, nrhs: 1),
        (lhs: 24, nrhs: 3),
        (lhs: 24, nrhs: 1),
        (lhs: 25, nrhs: 3),
        (lhs: 25, nrhs: 1),
        (lhs: 23, nrhs: 3)
    ]

    // Stack

    var yyStack: [(stateOrRule: CitronStateOrRule, symbolCode: CitronSymbolCode, symbol: CitronSymbol)]  = [
        (stateOrRule: .state(0), symbolCode: 0, symbol: .yyBaseOfStack)
    ]
    var maxStackSize: Int?
    // Tracing

    var isTracingEnabled: Bool = false
    let yySymbolName: [String] = [
        "$", "ADD", "SUB", "MUL",
        "DIV", "INT", "FLOAT", "BOOL",
        "IDENTIFIER", "L_BR", "R_BR", "IF",
        "THEN", "ELSE", "LET", "REC",
        "EQUAL", "IN", "ARRAY_CREATE", "DOT",
        "LEFT_ARROW", "COMMA", "root", "expr",
        "elements", "element_vars", "arithOps", "const",
        "var", "vars", "arg", "args"
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
        /*  20 */ "expr ::= LET L_BR element_vars(a) R_BR EQUAL expr(b) IN expr(c)",
        /*  21 */ "expr ::= LET var(a) EQUAL expr(b) IN expr(c)",
        /*  22 */ "expr ::= ARRAY_CREATE expr(num) expr(element)",
        /*  23 */ "expr ::= expr(arr) DOT L_BR expr(index) R_BR LEFT_ARROW expr(value)",
        /*  24 */ "expr ::= expr(arr) DOT L_BR expr(index) R_BR",
        /*  25 */ "expr ::= var(a) args(b)",
        /*  26 */ "expr ::= var(a)",
        /*  27 */ "elements ::= expr(a) COMMA elements(list)",
        /*  28 */ "elements ::= expr(a)",
        /*  29 */ "element_vars ::= var(a) COMMA element_vars(list)",
        /*  30 */ "element_vars ::= var(a)",
        /*  31 */ "expr ::= L_BR elements(e) R_BR"
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
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule00(a: a))
            }
        case 1: /* arithOps ::= expr(a) ADD expr(b) */
            func codeBlockForRule01(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .add, args: [a, b])
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule01(a: a, b: b))
            }
        case 2: /* arithOps ::= expr(a) SUB expr(b) */
            func codeBlockForRule02(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .sub, args: [a, b])
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule02(a: a, b: b))
            }
        case 3: /* arithOps ::= expr(a) MUL expr(b) */
            func codeBlockForRule03(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .mul, args: [a, b])
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule03(a: a, b: b))
            }
        case 4: /* arithOps ::= expr(a) DIV expr(b) */
            func codeBlockForRule04(a: Expr, b: Expr) throws -> Expr {
    return .arithOps(ops: .div, args: [a, b])
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule04(a: a, b: b))
            }
        case 5: /* expr ::= arithOps(a) */
            func codeBlockForRule05(a: Expr) throws -> Expr {
    return a
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule05(a: a))
            }
        case 6: /* expr ::= const(a) */
            func codeBlockForRule06(a: Const) throws -> Expr {
    return .const(const: a)
 }
            if case .yy56(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule06(a: a))
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
                return .yy46(try codeBlockForRule10(a: a))
            }
        case 11: /* vars ::= var(a) vars(list) */
            func codeBlockForRule11(a: Var, list: [Var]) throws -> [Var] {
    return [a] + list
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy26(let list) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy26(try codeBlockForRule11(a: a, list: list))
            }
        case 12: /* vars ::= var(a) */
            func codeBlockForRule12(a: Var) throws -> [Var] {
    return [a]
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy26(try codeBlockForRule12(a: a))
            }
        case 13: /* arg ::= const(a) */
            func codeBlockForRule13(a: Const) throws -> Expr {
    return .const(const: a)
 }
            if case .yy56(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule13(a: a))
            }
        case 14: /* arg ::= var(a) */
            func codeBlockForRule14(a: Var) throws -> Expr {
    return .var(variable: a)
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule14(a: a))
            }
        case 15: /* arg ::= L_BR expr(a) R_BR */
            func codeBlockForRule15(a: Expr) throws -> Expr {
    return a
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy28(try codeBlockForRule15(a: a))
            }
        case 16: /* args ::= arg(a) args(list) */
            func codeBlockForRule16(a: Expr, list: [Expr]) throws -> [Expr] {
    return [a] + list
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy29(let list) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy29(try codeBlockForRule16(a: a, list: list))
            }
        case 17: /* args ::= arg(a) */
            func codeBlockForRule17(a: Expr) throws -> [Expr] {
    return [a]
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy29(try codeBlockForRule17(a: a))
            }
        case 18: /* expr ::= IF expr(a) THEN expr(b) ELSE expr(c) */
            func codeBlockForRule18(a: Expr, b: Expr, c: Expr) throws -> Expr {
    return .if(cond: a, ifTrue:b, ifFalse:c)
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 4),
               case .yy28(let b) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let c) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule18(a: a, b: b, c: c))
            }
        case 19: /* expr ::= LET REC var(a) vars(b) EQUAL expr(c) IN expr(d) */
            func codeBlockForRule19(a: Var, b: [Var], c: Expr, d: Expr) throws -> Expr {
    return .letRec(name: a, args: b, bind: c, body: d)
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 5),
               case .yy26(let b) = yySymbolOnStack(distanceFromTop: 4),
               case .yy28(let c) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let d) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule19(a: a, b: b, c: c, d: d))
            }
        case 20: /* expr ::= LET L_BR element_vars(a) R_BR EQUAL expr(b) IN expr(c) */
            func codeBlockForRule20(a: [Var], b: Expr, c: Expr) throws -> Expr {
    return .readTuple(vars: a, bindings: b, body: c)
 }
            if case .yy26(let a) = yySymbolOnStack(distanceFromTop: 5),
               case .yy28(let b) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let c) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule20(a: a, b: b, c: c))
            }
        case 21: /* expr ::= LET var(a) EQUAL expr(b) IN expr(c) */
            func codeBlockForRule21(a: Var, b: Expr, c: Expr) throws -> Expr {
    return .let(varName: a, bind: b, body: c)
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 4),
               case .yy28(let b) = yySymbolOnStack(distanceFromTop: 2),
               case .yy28(let c) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule21(a: a, b: b, c: c))
            }
        case 22: /* expr ::= ARRAY_CREATE expr(num) expr(element) */
            func codeBlockForRule22(num: Expr, element: Expr) throws -> Expr {
    return .createArray(size: num, element: element)
 }
            if case .yy28(let num) = yySymbolOnStack(distanceFromTop: 1),
               case .yy28(let element) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule22(num: num, element: element))
            }
        case 23: /* expr ::= expr(arr) DOT L_BR expr(index) R_BR LEFT_ARROW expr(value) */
            func codeBlockForRule23(arr: Expr, index: Expr, value: Expr) throws -> Expr {
    return .writeArray(array: arr, index: index, value: value)
 }
            if case .yy28(let arr) = yySymbolOnStack(distanceFromTop: 6),
               case .yy28(let index) = yySymbolOnStack(distanceFromTop: 3),
               case .yy28(let value) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule23(arr: arr, index: index, value: value))
            }
        case 24: /* expr ::= expr(arr) DOT L_BR expr(index) R_BR */
            func codeBlockForRule24(arr: Expr, index: Expr) throws -> Expr {
    return .readArray(array: arr, index: index)
 }
            if case .yy28(let arr) = yySymbolOnStack(distanceFromTop: 4),
               case .yy28(let index) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy28(try codeBlockForRule24(arr: arr, index: index))
            }
        case 25: /* expr ::= var(a) args(b) */
            func codeBlockForRule25(a: Var, b: [Expr]) throws -> Expr {
    return .apply(function: a, args: b)
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 1),
               case .yy29(let b) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule25(a: a, b: b))
            }
        case 26: /* expr ::= var(a) */
            func codeBlockForRule26(a: Var) throws -> Expr {
    return .var(variable: a)
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy28(try codeBlockForRule26(a: a))
            }
        case 27: /* elements ::= expr(a) COMMA elements(list) */
            func codeBlockForRule27(a: Expr, list: [Expr]) throws -> [Expr] {
    return [a] + list
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy29(let list) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy29(try codeBlockForRule27(a: a, list: list))
            }
        case 28: /* elements ::= expr(a) */
            func codeBlockForRule28(a: Expr) throws -> [Expr] {
    return [a]
 }
            if case .yy28(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy29(try codeBlockForRule28(a: a))
            }
        case 29: /* element_vars ::= var(a) COMMA element_vars(list) */
            func codeBlockForRule29(a: Var, list: [Var]) throws -> [Var] {
    return [a] + list
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 2),
               case .yy26(let list) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy26(try codeBlockForRule29(a: a, list: list))
            }
        case 30: /* element_vars ::= var(a) */
            func codeBlockForRule30(a: Var) throws -> [Var] {
    return [a]
 }
            if case .yy46(let a) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy26(try codeBlockForRule30(a: a))
            }
        case 31: /* expr ::= L_BR elements(e) R_BR */
            func codeBlockForRule31(e: [Expr]) throws -> Expr {
    return .tuple(elements: e)
 }
            if case .yy29(let e) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy28(try codeBlockForRule31(e: e))
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
        if case .yy28(let result) = symbol {
            return result
        } else {
            fatalError("Unexpected mismatch in result type")
        }
    }

}
