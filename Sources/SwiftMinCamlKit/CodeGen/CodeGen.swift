//
//  CodeGen.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/13.
//

public struct CodeGen {
    typealias Reg = NasmX64Builder.Reg
    private let b = NasmX64Builder()
    private let startLabel = "start"
    private let exitLabel  = "mincaml_exit"

    public init() { }

    class Context {
        private var regInUse: Int = 0
        func useReg() -> Reg {
            defer {
                regInUse = regInUse + 1
            }
            return Reg.regs[regInUse]
        }

        func readReg(offset: Int) -> Reg {
            return Reg.regs[regInUse - offset]
        }

        func releaseReg() {
            regInUse = regInUse - 1
        }
    }

    public func gen(expr: Expr) -> String {
        b.raw("extern print_int") //FIXME: workaround. Need to emit all builtin function's label.
        b.raw("global \(startLabel)")
        b.section(.text)
        b.globalLabel(startLabel)
        // 16byte alignment
        b.and(.rsp, -16)
        // body
        genExpr(expr: expr, context: Context())
        // print rax
        b.mov(.rdi, .rax)
        b.sub(.rsp, -16)
        b.call("print_int")
        b.add(.rsp, 16)
        // exit
        b.jmp(exitLabel)
        genExit()
        return b.code
    }

    private func genExpr(expr: Expr, context: Context) {
        switch expr {
        case let .int(int):
            b.mov(context.useReg(), int)
        case let .add(lhs: lhs, rhs: rhs):
            if labelOf(node: lhs) > labelOf(node: rhs) {
                genExpr(expr: lhs, context: context)
                genExpr(expr: rhs, context: context)
            } else {
                genExpr(expr: rhs, context: context)
                genExpr(expr: lhs, context: context)
            }
            b.add(context.readReg(offset: 2), context.readReg(offset: 1))
            context.releaseReg()
        case let .sub(lhs: lhs, rhs: rhs):
            if labelOf(node: lhs) > labelOf(node: rhs) {
                genExpr(expr: lhs, context: context)
                genExpr(expr: rhs, context: context)
            } else {
                genExpr(expr: rhs, context: context)
                genExpr(expr: lhs, context: context)
            }
            b.sub(context.readReg(offset: 2), context.readReg(offset: 1))
            context.releaseReg()
        case let .mul(lhs: lhs, rhs: rhs):
            if labelOf(node: lhs) > labelOf(node: rhs) {
                genExpr(expr: lhs, context: context)
                genExpr(expr: rhs, context: context)
            } else {
                genExpr(expr: rhs, context: context)
                genExpr(expr: lhs, context: context)
            }
            if context.readReg(offset: 2) == .rax {
                b.mul(context.readReg(offset: 1))
            } else {
                b.push(.rax)
                b.mov(.rax, context.readReg(offset: 2))
                b.mul(context.readReg(offset: 1))
                b.mov(context.readReg(offset: 2), .rax)
                b.pop(.rax)
            }
            context.releaseReg()
        case let .let(name: name, bind: bind, body: body):
            return genLet(name: name, bind: bind, body: body, context: context)
        default:
            fatalError("Not implemented")
        }
    }

    private func genLet(name: TypedVar, bind: Expr, body: Expr, context: Context) {
        //FIXME: implement.
        genExpr(expr: bind, context: context)
        genExpr(expr: body, context: context)

    }

    private func genApp(expr: Expr) {
        guard case let .app(function: function, args: args) = expr else {
            fatalError("`expr` must be Expr.apply but \(expr)")
        }
        //FIXME: Support only .int arg now.
        guard case let .some(.int(int)) = args.first else {
            fatalError("Support only int arg for now.")
        }
        //FIXME: spill out if needed
        //FIXME: support 2~ args
        b.mov(.rdi, int)
        b.call(function.rawValue)
    }

    private func genExit() {
        b.globalLabel(exitLabel)
        b.mov(.rax, .exit)
        b.add(.rax, "0x2000000")
        b.xor(.rdi, .rdi)
        b.syscall()
    }

    private func labelOf(node: Expr) -> Int {
        switch node {
        case .var, .int, .bool, .float:
            return 1
        case let .add(lhs: lhs, rhs: rhs),
             let .sub(lhs: lhs, rhs: rhs),
             let .mul(lhs: lhs, rhs: rhs),
             let .div(lhs: lhs, rhs: rhs):
            
            let (left, right) = (labelOf(node: lhs), labelOf(node: rhs))
            let maxLabel = max(left, right)
            
            if left == right, maxLabel < Reg.regs.count {
                return maxLabel + 1
            }
            if left == right, maxLabel == Reg.regs.count {
                return maxLabel
            }
            return maxLabel
        default:
            fatalError("Not implemented!")
        }
    }
}

