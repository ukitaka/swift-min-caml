// Name of the output Swift class

%class_name Parser


// Token type

%preface {
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
}

// Type for terminals

%token_type Token


// Type for non-terminals

%nonterminal_type root Expr
%nonterminal_type expr Expr
%nonterminal_type arithOps Expr
%nonterminal_type const Const
%nonterminal_type var Var
%nonterminal_type arg Expr
%nonterminal_type args "[Expr]"

// Associativity and precedences

%left_associative ADD SUB.
%left_associative MUL DIV.

// Grammar rules

root ::= expr(a). {
    return a
}

arithOps ::= expr(a) ADD expr(b). {
    return .arithOps(ops: .add, args: [a, b])
}

arithOps ::= expr(a) SUB expr(b). {
    return .arithOps(ops: .sub, args: [a, b])
}

arithOps ::= expr(a) MUL expr(b). {
    return .arithOps(ops: .mul, args: [a, b])
}

arithOps ::= expr(a) DIV expr(b). {
    return .arithOps(ops: .div, args: [a, b])
}

expr ::= arithOps(a). {
    return a
}

expr ::= const(a). {
    return .const(const: a)
}

const ::= INT(a). {
    return .integer(a.asInt())
}

const ::= FLOAT(a). {
    return .float(a.asFloat())
}

const ::= BOOL(a). {
    return .bool(a.asBool())
}

var ::= IDENTIFIER(a). {
    return Var(rawValue: a.asIdentifier())
}

arg ::= const(a). {
    return .const(const: a)
}

arg ::= var(a). {
    return .var(variable: a)
}

arg ::= L_BR expr(a) R_BR. {
    return a
}

args ::= arg(a) args(list). {
    return [a] + list
}

args ::= arg(a). {
    return [a]
}

expr ::= var(a) args(b). {
    return .apply(function: a, args: b)
}

expr ::= var(a). {
    return .var(variable: a)
}
