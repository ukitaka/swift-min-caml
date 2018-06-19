// Name of the output Swift class

%class_name Parser


// Type for terminals

%token_type Int


// Type for non-terminals

%nonterminal_type root Expr
%nonterminal_type expr Expr
%nonterminal_type const Const

// Associativity and precedences

%left_associative ADD SUBTRACT.
%left_associative MULTIPLY DIVIDE.

// Grammar rules

root ::= expr(a). {
    return a
}

expr ::= expr(a) ADD expr(b). {
    return .arithOps(ops: .add, args: [a, b])
}

expr ::= expr(a) SUBTRACT expr(b). {
    return .arithOps(ops: .sub, args: [a, b])
}

expr ::= expr(a) MULTIPLY expr(b). {
    return .arithOps(ops: .mul, args: [a, b])
}

expr ::= expr(a) DIVIDE expr(b). {
    return .arithOps(ops: .div, args: [a, b])
}

expr ::= const(a). {
    return .const(const: a)
}

const ::= INTEGER(a). {
    return .integer(a)
}

