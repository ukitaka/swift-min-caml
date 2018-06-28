// Name of the output Swift class

%class_name Parser

// Type for terminals

%token_type Token

// Type for non-terminals

%nonterminal_type root Expr
%nonterminal_type expr Expr
%nonterminal_type simple_expr Expr
%nonterminal_type func_def FuncDef
%nonterminal_type formal_args "[TypedVar]"
%nonterminal_type actual_args "[Expr]"
%nonterminal_type elems "[Expr]"
%nonterminal_type pat "[TypedVar]"


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

expr ::= LET REC func_def(a) IN expr(b). {
    return .letRec(funcDef: a, bind: b)
}

expr ::= simple_expr(a) actual_args(b). {
    return .app(function: a, args: b)
}

expr ::= elems(e). {
    return .tuple(elements: e)
}

expr ::= LET L_PAREN pat(p) R_PAREN EQUAL expr(a) IN expr(b). {
    return .letTuple(vars: p, binding: a, body: b)
}

func_def ::= IDENTIFIER(a) formal_args(b) EQUAL expr(c). {
    return FuncDef(name: TypedVar(name: a.asID()), args: b, body: c)
}

formal_args ::= IDENTIFIER(a) formal_args(b). {
    return [TypedVar(name: a.asID())] + b
}

formal_args ::= IDENTIFIER(a). {
    return [TypedVar(name: a.asID())]
}

actual_args ::= actual_args(a) simple_expr(b). {
    return a + [b]
}

actual_args ::= simple_expr(a). {
    return [a]
}

elems ::= elems(a) COMMA expr(b). {
    return a + [b]
}

elems ::= expr(a) COMMA expr(b). {
    return [a, b]
}

pat ::= pat(a) COMMA IDENTIFIER(b). {
    return a + [TypedVar(name: b.asID())]
}

pat ::= IDENTIFIER(a) COMMA IDENTIFIER(b). {
    return [TypedVar(name: a.asID()), TypedVar(name: b.asID())]
}
