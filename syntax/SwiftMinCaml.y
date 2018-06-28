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

%left_associative ADD SUB.
%left_associative MUL DIV.

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

expr ::= expr(lhs) ADD expr(rhs). {
    return .add(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) SUB expr(rhs). {
    return .sub(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) MUL expr(rhs). {
    return .sub(lhs: lhs, rhs: rhs)
}

expr ::= expr(lhs) DIV expr(rhs). {
    return .div(lhs: lhs, rhs: rhs)
}
