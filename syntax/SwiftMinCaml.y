// Name of the output Swift class

%class_name Parser

// Type for terminals

%token_type Token

// Type for non-terminals

%nonterminal_type root Expr
%nonterminal_type expr Expr

// Associativity and precedences

%left_associative ADD SUB.
%left_associative MUL DIV.

// Grammar rules

root ::= expr(e). {
    return e
}

expr ::= INT(t). {
    return .int(t.asInt())
}

expr ::= FLOAT(t). {
    return .float(t.asFloat())
}

expr ::= BOOL(t). {
    return .bool(t.asBool())
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
