// Name of the output Swift class

%class_name Parser

// Type for terminals

%token_type Token

// Type for non-terminals

%nonterminal_type root Expr
%nonterminal_type expr Expr
%nonterminal_type simple_expr Expr
%nonterminal_type var Expr

// Associativity and precedences

%nonassociative IN.
%right_associative LET.
%right_associative SEMICOLON.
%right_associative IF.
%left_associative COMMA.
%left_associative EQUAL LESS_GREATER LESS GREATER LESS_EQUAL GREATER_EQUAL.
%left_associative ADD SUB F_ADD F_SUB.
%left_associative F_MUL F_DIV.
%right_associative MINUS F_MINUS.
%left_associative DOT.

// Grammar rules

root ::= expr(e). {
    return e
}

simple_expr ::= L_PAREN expr(e) R_PAREN. {
    return e
}

simple_expr ::= L_PAREN R_PAREN. {
    return .unit
}

simple_expr ::= BOOL(t). {
    return .bool(t.asBool())
}

simple_expr ::= INT(t). {
    return .int(t.asInt())
}

simple_expr ::= FLOAT(t). {
    return .float(t.asFloat())
}

simple_expr ::= IDENTIFIER(t). {
    return .var(name: t.asID())
}

simple_expr ::= simple_expr(e1) DOT L_PAREN expr(e2) R_PAREN. {
    return .get(array: e1, index: e2)
}

expr ::= simple_expr(e). {
    return e
}

expr ::= NOT expr(e). {
    return .not(op: e)
}

expr ::= MINUS expr(e). {
    switch e {
        case let .float(f):
            return .float(-f)
        default:
            return .neg(op: e)
    }
}

expr ::= expr(lhs) ADD expr(rhs). {
    return .add(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) SUB expr(rhs). {
    return .sub(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) EQUAL expr(rhs). {
    return .eq(lhs: lhs, rhs: rhs)
}

// <>
expr ::= expr(lhs) LESS_GREATER expr(rhs). {
    return .not(op: .eq(lhs: lhs, rhs: rhs))
}

// (lhs < rhs) <=> !(rhs <= lhs)
expr ::= expr(lhs) LESS expr(rhs). {
    return .not(op: .le(lhs: rhs, rhs: lhs))
}

// (lhs > rhs) <=> !(lhs <= rhs)
expr ::= expr(lhs) GREATER expr(rhs). {
    return .not(op: .le(lhs: lhs, rhs: rhs))
}

expr ::= expr(lhs) LESS_EQUAL expr(rhs). {
    return .le(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) GREATER_EQUAL expr(rhs). {
    return .le(lhs: rhs, rhs: lhs)
}

expr ::= IF expr(a) THEN expr(b) ELSE expr(c). {
    return .if(cond: a, ifTrue:b, ifFalse:c)
}

expr ::= F_MINUS expr(e). {
    return .fneg(op: e)
}

expr ::= expr(lhs) F_ADD expr(rhs). {
    return .fadd(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) F_SUB expr(rhs). {
    return .fsub(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) F_MUL expr(rhs). {
    return .fmul(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) F_DIV expr(rhs). {
    return .fdiv(lhs: lhs, rhs: rhs)
}

expr ::= LET IDENTIFIER(a) EQUAL expr(b) IN expr(c). {
    return .let(name: TypedVar(name: a.asID()), bind: b, body: c)
}








