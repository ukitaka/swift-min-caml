import Foundation

let p = ProcessInfo.processInfo
let input = (p.arguments.count > 1) ? p.arguments[1] : "1*2+3*(4+5)"
let expr = try! Expr.parser.run(sourceName: "main", input: input)
let output = CodeGen().gen(expr: expr)
print(output)
