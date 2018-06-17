//
//  CodeGen.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/13.
//

struct CodeGen {
    typealias Reg = NasmX64Builder.Reg
    private let b = NasmX64Builder()
    private let startLabel = "start"
    private let exitLabel  = "mincaml_exit"
    
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

    func gen(expr: Expr) -> String {
        b.raw("global \(startLabel)")
        b.section(.text)
        b.globalLabel(startLabel)
        b.and(.rsp, -16) // 16byte alignment
        genExpr(expr: expr, context: Context()) // body
        b.jmp(exitLabel)
        genExit()
        return b.code
    }
    
    private func genExpr(expr: Expr, context: Context) {
        switch expr {
        case let .const(const: const):
            return genConst(const: const, context: context)
        case let .arithOps(ops: ops, args: args):
            return genArithOps(ops: ops, args: args, context: context)
        default:
            fatalError("Not implemented")
        }
    }
    
    private func genArithOps(ops: ArithOps, args: [Expr], context: Context) {
        //FIXME: Now support only binary operators.
        let lhs = args.first!
        let rhs = args.last!
        if labelOf(node: lhs) > labelOf(node: rhs) {
            genExpr(expr: lhs, context: context)
            genExpr(expr: rhs, context: context)
        } else {
            genExpr(expr: rhs, context: context)
            genExpr(expr: lhs, context: context)
        }
        switch ops {
        case .add:
            b.add(context.readReg(offset: 2), context.readReg(offset: 1))
        case .sub:
            b.sub(context.readReg(offset: 2), context.readReg(offset: 1))
        case .mul:
            b.mul(context.readReg(offset: 2), context.readReg(offset: 1))
        case .div:
            fatalError("Not implemented!")
        }
        context.releaseReg()
    }
    
    private func genConst(const: Const, context: Context) {
        switch const {
        case let .integer(n):
            b.mov(context.useReg(), n)
        case .float(_):
            fatalError("Not implemented")
        case .bool(_):
            fatalError("Not implemented")
        }
    }
    
    private func genCall(expr: Expr) {
        guard let apply = expr.asApply else {
            fatalError("`expr` must be Expr.apply but \(expr)")
        }
        //FIXME: Support only Const.int arg now.
        let num = apply.args.first!.asConst!.asInteger!
        //FIXME: spill out if needed
        //FIXME: support 2~ args
        b.mov(.rdi, num)
        b.call(apply.function.asVar!.rawValue)
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
        case .var, .const:
            return 1
        case let .arithOps(ops: _, args: args):
            let labels = args.map(labelOf)
            let max = labels.max() ?? 1
            let count = labels.filter { $0 == max }.count
            if count > 1, max < Reg.regs.count {
                return max + 1
            }
            if count > 1, max == Reg.regs.count {
                return max
            }
            if count == 1 {
                return max
            }
            fatalError("unreachable.")
        default:
            fatalError("Not implemented!")
        }
    }
}

class NasmX64Builder {
    enum Reg: String {
        case rsp
        case rbp
        case rax // for return
        case rdi // arg1
        case rsi // arg2
        case rdx // arg3
        case rcx // arg4
        case r8  // arg5
        case r9  // arg6

        static var regs: [Reg] {
            return [.rax, .rdi, .rsi, .rdx, .rcx, .r8, .r9]
        }
    }
    
    enum Section: String {
        case data
        case text
    }
    
    enum Inst: String {
        case mov
        case add
        case sub
        case mul
        case and
        case xor
        case jmp
        case call
        case syscall
    }
    
    enum SystemCall: Int {
        case exit  = 1
        case write = 4
    }
    
    var code: String

    init() {
        self.code = ""
    }
    
    func raw(_ code: String) {
        self.code += code + "\n"
    }

    func section(_ section: Section) {
        self.raw("section .\(section)")
    }
    
    func inst(_ inst: Inst, _ dst: Any, _ src: Any) {
        self.raw("\(inst.rawValue) \(dst), \(src)")
    }
    
    func globalLabel(_ label: String) {
        self.raw("\(label):")
    }

    func mov(_ dst: Reg, _ src: Reg) {
        self.inst(.mov, dst, src)
    }

    func mov(_ dst: Reg, _ src: SystemCall) {
        self.inst(.mov, dst, src.rawValue)
    }
    
    func mov(_ dst: Reg, _ src: Int) {
        self.inst(.mov, dst, src)
    }
    
    func add(_ dst: Reg, _ src: Reg) {
        self.inst(.add, dst, src)
    }
    
    func add(_ dst: Reg, _ src: Int) {
        self.inst(.add, dst, src)
    }
    
    func add(_ dst: Reg, _ src: String) {
        self.inst(.add, dst, src)
    }

    func sub(_ dst: Reg, _ src: Reg) {
        self.inst(.sub, dst, src)
    }

    func mul(_ dst: Reg, _ src: Reg) {
        self.inst(.mul, dst, src)
    }

    func and(_ dst: Reg, _ src: Int) {
        self.inst(.and, dst, src)
    }
    
    func xor(_ dst: Reg, _ src: Reg) {
        self.inst(.xor, dst, src)
    }
    
    func jmp(_ label: String) {
        self.raw("\(Inst.jmp) \(label)")
    }
    
    func call(_ label: String) {
        self.raw("\(Inst.call) \(label)")
    }

    func syscall() {
        self.raw(Inst.syscall.rawValue)
    }
}
