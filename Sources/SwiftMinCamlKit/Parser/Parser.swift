// This file is automatically generated by Citron version 1.0.
//
// The parser class defined below conforms to the CitronParser protocol
// defined in CitronParser.swift.
//
// The authors of Citron disclaim copyright to the source code in this file.

// Parser class

import CitronKit

class Parser: CitronParser {
    // Types

    typealias CitronSymbolCode = UInt8
    typealias CitronStateNumber = UInt8
    typealias CitronRuleNumber = UInt8

    enum CitronTokenCode: CitronSymbolCode {
        case ADD = 1
        case SUB = 2
        case MUL = 3
        case DIV = 4
        case L_PAREN = 5
        case R_PAREN = 6
        case BOOL = 7
        case INT = 8
        case FLOAT = 9
        case IDENTIFIER = 10
        case DOT = 11
        case NOT = 12
        case MINUS = 13
        case EQUAL = 14
        case LESS_GREATER = 15
        case LESS = 16
        case GREATER = 17
        case LESS_EQUAL = 18
        case GREATER_EQUAL = 19
    }

    typealias CitronToken = Token

    enum CitronSymbol {
        case yyBaseOfStack
        case yy0(CitronToken)
        case yy12(Expr)
    }

    typealias CitronResult = Expr

    // Counts

    let yyNumberOfSymbols: Int = 24
    let yyNumberOfStates: Int = 32

    // Action tables

    let yyLookaheadAction: [(CitronSymbolCode, CitronParsingAction)] = [
        /*   0 */ (1, .SH(14)), (2, .SH(13)), (3, .SH(3)), (4, .SH(2)), (11, .SH(30)),
        /*   5 */ (6, .SR(7)), (5, .SH(12)), (1, .SH(14)), (2, .SH(13)), (3, .SH(3)),
        /*  10 */ (4, .SH(2)), (24, .RD(2)), (6, .SR(1)), (14, .SH(11)), (15, .SH(9)),
        /*  15 */ (16, .SH(7)), (17, .SH(6)), (18, .SH(5)), (19, .SH(4)), (24, .RD(2)),
        /*  20 */ (14, .SH(11)), (15, .SH(9)), (16, .SH(7)), (17, .SH(6)), (18, .SH(5)),
        /*  25 */ (19, .SH(4)), (0, .RD(0)), (1, .SH(14)), (2, .SH(13)), (3, .SH(3)),
        /*  30 */ (4, .SH(2)), (14, .SH(11)), (15, .SH(9)), (16, .SH(7)), (17, .SH(6)),
        /*  35 */ (18, .SH(5)), (19, .SH(4)), (21, .SH(16)), (22, .SH(31)), (24, .RD(2)),
        /*  40 */ (14, .SH(11)), (15, .SH(9)), (16, .SH(7)), (17, .SH(6)), (18, .SH(5)),
        /*  45 */ (19, .SH(4)), (1, .SH(14)), (2, .SH(13)), (3, .SH(3)), (4, .SH(2)),
        /*  50 */ (20, .ACCEPT), (21, .SH(17)), (22, .SH(31)), (21, .SH(28)), (22, .SH(31)),
        /*  55 */ (21, .SH(29)), (22, .SH(31)), (21, .SH(20)), (22, .SH(31)), (14, .SH(11)),
        /*  60 */ (15, .SH(9)), (16, .SH(7)), (17, .SH(6)), (18, .SH(5)), (19, .SH(4)),
        /*  65 */ (5, .SH(1)), (6, .SR(2)), (7, .SR(3)), (8, .SR(4)), (9, .SR(5)),
        /*  70 */ (10, .SR(6)), (24, .RD(2)), (12, .SH(10)), (13, .SH(8)), (3, .SH(3)),
        /*  75 */ (4, .SH(2)), (21, .SH(21)), (22, .SH(31)), (21, .SH(22)), (22, .SH(31)),
        /*  80 */ (21, .SH(23)), (22, .SH(31)), (21, .SH(24)), (22, .SH(31)), (24, .RD(2)),
        /*  85 */ (14, .SH(11)), (15, .SH(9)), (16, .SH(7)), (17, .SH(6)), (18, .SH(5)),
        /*  90 */ (19, .SH(4)), (5, .SH(1)), (24, .RD(2)), (7, .SR(3)), (8, .SR(4)),
        /*  95 */ (9, .SR(5)), (10, .SR(6)), (24, .RD(2)), (12, .SH(10)), (13, .SH(8)),
        /* 100 */ (21, .SH(19)), (22, .SH(31)), (21, .SH(25)), (22, .SH(31)), (21, .SH(18)),
        /* 105 */ (22, .SH(31)), (24, .RD(2)), (24, .RD(2)), (21, .SH(15)), (22, .SH(31)),
        /* 110 */ (21, .SH(27)), (22, .SH(31)), (21, .SH(26)), (22, .SH(31)),
    ]

    let yyShiftUseDefault: Int = 114
    let yyShiftOffsetMin: Int = -7
    let yyShiftOffsetMax: Int = 86
    let yyShiftOffset: [Int] = [
        /*     0 */ 86, 60, 86, 86, 86, 86, 86, 86, 86, 86,
        /*    10 */ 86, 86, 86, 86, 86, -1, 6, 26, 45, 45,
        /*    20 */ 45, 45, 45, 45, 45, 45, 71, 71, 17, 17,
        /*    30 */ 1, -7,
    ]

    let yyReduceUseDefault: Int = -1
    let yyReduceOffsetMin: Int = 0
    let yyReduceOffsetMax: Int = 91
    let yyReduceOffset: [Int] = [
        /*     0 */ 30, 16, 32, 34, 36, 55, 57, 59, 61, 79,
        /*    10 */ 81, 83, 87, 89, 91,
    ]

    let yyDefaultAction: [CitronParsingAction] = [
        /*     0 */ .ERROR, .ERROR, .ERROR, .ERROR, .ERROR,
        /*     5 */ .ERROR, .ERROR, .ERROR, .ERROR, .ERROR,
        /*    10 */ .ERROR, .ERROR, .ERROR, .ERROR, .ERROR,
        /*    15 */ .ERROR, .ERROR, .ERROR, .RD(13), .RD(14),
        /*    20 */ .RD(18), .RD(17), .RD(16), .RD(15), .RD(10),
        /*    25 */ .RD(9), .RD(11), .RD(12), .RD(20), .RD(19),
        /*    30 */ .ERROR, .RD(8),
    ]

    // Fallback

    let yyHasFallback: Bool = false
    let yyFallback: [CitronSymbolCode] = []

    // Wildcard

    let yyWildcard: CitronSymbolCode? = nil

    // Rules

    let yyRuleInfo: [(lhs: CitronSymbolCode, nrhs: UInt)] = [
        (lhs: 20, nrhs: 1),
        (lhs: 22, nrhs: 3),
        (lhs: 22, nrhs: 2),
        (lhs: 22, nrhs: 1),
        (lhs: 22, nrhs: 1),
        (lhs: 22, nrhs: 1),
        (lhs: 22, nrhs: 1),
        (lhs: 22, nrhs: 5),
        (lhs: 21, nrhs: 1),
        (lhs: 21, nrhs: 2),
        (lhs: 21, nrhs: 2),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
        (lhs: 21, nrhs: 3),
    ]

    // Stack

    var yyStack: [(stateOrRule: CitronStateOrRule, symbolCode: CitronSymbolCode, symbol: CitronSymbol)] = [
        (stateOrRule: .state(0), symbolCode: 0, symbol: .yyBaseOfStack),
    ]
    var maxStackSize: Int?
    // Tracing

    var isTracingEnabled: Bool = false
    let yySymbolName: [String] = [
        "$", "ADD", "SUB", "MUL",
        "DIV", "L_PAREN", "R_PAREN", "BOOL",
        "INT", "FLOAT", "IDENTIFIER", "DOT",
        "NOT", "MINUS", "EQUAL", "LESS_GREATER",
        "LESS", "GREATER", "LESS_EQUAL", "GREATER_EQUAL",
        "root", "expr", "simple_expr", "var",
    ]
    let yyRuleText: [String] = [
        /*   0 */ "root ::= expr(e)",
        /*   1 */ "simple_expr ::= L_PAREN expr(e) R_PAREN",
        /*   2 */ "simple_expr ::= L_PAREN R_PAREN",
        /*   3 */ "simple_expr ::= BOOL(t)",
        /*   4 */ "simple_expr ::= INT(t)",
        /*   5 */ "simple_expr ::= FLOAT(t)",
        /*   6 */ "simple_expr ::= IDENTIFIER(t)",
        /*   7 */ "simple_expr ::= simple_expr(e1) DOT L_PAREN expr(e2) R_PAREN",
        /*   8 */ "expr ::= simple_expr(e)",
        /*   9 */ "expr ::= NOT expr(e)",
        /*  10 */ "expr ::= MINUS expr(e)",
        /*  11 */ "expr ::= expr(lhs) ADD expr(rhs)",
        /*  12 */ "expr ::= expr(lhs) SUB expr(rhs)",
        /*  13 */ "expr ::= expr(lhs) EQUAL expr(rhs)",
        /*  14 */ "expr ::= expr(lhs) LESS_GREATER expr(rhs)",
        /*  15 */ "expr ::= expr(lhs) LESS expr(rhs)",
        /*  16 */ "expr ::= expr(lhs) GREATER expr(rhs)",
        /*  17 */ "expr ::= expr(lhs) LESS_EQUAL expr(rhs)",
        /*  18 */ "expr ::= expr(lhs) GREATER_EQUAL expr(rhs)",
        /*  19 */ "expr ::= expr(lhs) MUL expr(rhs)",
        /*  20 */ "expr ::= expr(lhs) DIV expr(rhs)",
    ]

    // Function definitions

    func yyTokenToSymbol(_ token: CitronToken) -> CitronSymbol {
        return .yy0(token)
    }

    func yyInvokeCodeBlockForRule(ruleNumber: CitronRuleNumber) throws -> CitronSymbol {
        switch ruleNumber {
        case 0: /* root ::= expr(e) */
            func codeBlockForRule00(e: Expr) throws -> Expr {
                return e
            }
            if case let .yy12(e) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule00(e: e))
            }
        case 1: /* simple_expr ::= L_PAREN expr(e) R_PAREN */
            func codeBlockForRule01(e: Expr) throws -> Expr {
                return e
            }
            if case let .yy12(e) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy12(try codeBlockForRule01(e: e))
            }
        case 2: /* simple_expr ::= L_PAREN R_PAREN */
            func codeBlockForRule02() throws -> Expr {
                return .unit
            }
            return .yy12(try codeBlockForRule02())
        case 3: /* simple_expr ::= BOOL(t) */
            func codeBlockForRule03(t: Token) throws -> Expr {
                return .bool(t.asBool())
            }
            if case let .yy0(t) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule03(t: t))
            }
        case 4: /* simple_expr ::= INT(t) */
            func codeBlockForRule04(t: Token) throws -> Expr {
                return .int(t.asInt())
            }
            if case let .yy0(t) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule04(t: t))
            }
        case 5: /* simple_expr ::= FLOAT(t) */
            func codeBlockForRule05(t: Token) throws -> Expr {
                return .float(t.asFloat())
            }
            if case let .yy0(t) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule05(t: t))
            }
        case 6: /* simple_expr ::= IDENTIFIER(t) */
            func codeBlockForRule06(t: Token) throws -> Expr {
                return .var(name: t.asID())
            }
            if case let .yy0(t) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule06(t: t))
            }
        case 7: /* simple_expr ::= simple_expr(e1) DOT L_PAREN expr(e2) R_PAREN */
            func codeBlockForRule07(e1: Expr, e2: Expr) throws -> Expr {
                return .get(array: e1, index: e2)
            }
            if case let .yy12(e1) = yySymbolOnStack(distanceFromTop: 4),
                case let .yy12(e2) = yySymbolOnStack(distanceFromTop: 1) {
                return .yy12(try codeBlockForRule07(e1: e1, e2: e2))
            }
        case 8: /* expr ::= simple_expr(e) */
            func codeBlockForRule08(e: Expr) throws -> Expr {
                return e
            }
            if case let .yy12(e) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule08(e: e))
            }
        case 9: /* expr ::= NOT expr(e) */
            func codeBlockForRule09(e: Expr) throws -> Expr {
                return .not(op: e)
            }
            if case let .yy12(e) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule09(e: e))
            }
        case 10: /* expr ::= MINUS expr(e) */
            func codeBlockForRule10(e: Expr) throws -> Expr {
                switch e {
                case let .float(f):
                    return .float(-f)
                default:
                    return .neg(op: e)
                }
            }
            if case let .yy12(e) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule10(e: e))
            }
        case 11: /* expr ::= expr(lhs) ADD expr(rhs) */
            func codeBlockForRule11(lhs: Expr, rhs: Expr) throws -> Expr {
                return .add(lhs: lhs, rhs: rhs)
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule11(lhs: lhs, rhs: rhs))
            }
        case 12: /* expr ::= expr(lhs) SUB expr(rhs) */
            func codeBlockForRule12(lhs: Expr, rhs: Expr) throws -> Expr {
                return .sub(lhs: lhs, rhs: rhs)
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule12(lhs: lhs, rhs: rhs))
            }
        case 13: /* expr ::= expr(lhs) EQUAL expr(rhs) */
            func codeBlockForRule13(lhs: Expr, rhs: Expr) throws -> Expr {
                return .eq(lhs: lhs, rhs: rhs)
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule13(lhs: lhs, rhs: rhs))
            }
        case 14: /* expr ::= expr(lhs) LESS_GREATER expr(rhs) */
            func codeBlockForRule14(lhs: Expr, rhs: Expr) throws -> Expr {
                return .not(.eq(lhs: lhs, rhs: rhs))
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule14(lhs: lhs, rhs: rhs))
            }
        case 15: /* expr ::= expr(lhs) LESS expr(rhs) */
            func codeBlockForRule15(lhs: Expr, rhs: Expr) throws -> Expr {
                return .not(.le(lhs: rhs, rhs: lhs))
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule15(lhs: lhs, rhs: rhs))
            }
        case 16: /* expr ::= expr(lhs) GREATER expr(rhs) */
            func codeBlockForRule16(lhs: Expr, rhs: Expr) throws -> Expr {
                return .not(.le(lhs: lhs, rhs: rhs))
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule16(lhs: lhs, rhs: rhs))
            }
        case 17: /* expr ::= expr(lhs) LESS_EQUAL expr(rhs) */
            func codeBlockForRule17(lhs: Expr, rhs: Expr) throws -> Expr {
                return .le(lhs: lhs, rhs: rhs)
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule17(lhs: lhs, rhs: rhs))
            }
        case 18: /* expr ::= expr(lhs) GREATER_EQUAL expr(rhs) */
            func codeBlockForRule18(lhs: Expr, rhs: Expr) throws -> Expr {
                return .le(lhs: rhs, rhs: lhs)
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule18(lhs: lhs, rhs: rhs))
            }
        case 19: /* expr ::= expr(lhs) MUL expr(rhs) */
            func codeBlockForRule19(lhs: Expr, rhs: Expr) throws -> Expr {
                return .sub(lhs: lhs, rhs: rhs)
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule19(lhs: lhs, rhs: rhs))
            }
        case 20: /* expr ::= expr(lhs) DIV expr(rhs) */
            func codeBlockForRule20(lhs: Expr, rhs: Expr) throws -> Expr {
                return .div(lhs: lhs, rhs: rhs)
            }
            if case let .yy12(lhs) = yySymbolOnStack(distanceFromTop: 2),
                case let .yy12(rhs) = yySymbolOnStack(distanceFromTop: 0) {
                return .yy12(try codeBlockForRule20(lhs: lhs, rhs: rhs))
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
        if case let .yy12(result) = symbol {
            return result
        } else {
            fatalError("Unexpected mismatch in result type")
        }
    }
}
