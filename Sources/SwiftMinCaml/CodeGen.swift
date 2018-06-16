//
//  CodeGen.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/13.
//

struct CodeGen {
    private let b = NasmX64Builder()
    private let startLabel = "start"
    private let exitLabel  = "mincaml_exit"

    func gen(expr: Expr) -> String {
        b.raw("global \(startLabel)")
        b.section(.text)
        b.globalLabel(startLabel)
        b.and(.rsp, -16) // 16byte alignment
        b.jmp(exitLabel)
        genExit()
        return b.code
    }
    
    private func genExit() {
        b.globalLabel(exitLabel)
        b.mov(.rax, .exit)
        b.add(.rax, "0x2000000")
        b.xor(.rdi, .rdi)
        b.syscall()
    }
}

class NasmX64Builder {
    enum Reg: String {
        case rsp
        case rbp
        case rax
        case rcx
        case rdi
    }
    
    enum Section: String {
        case data
        case text
    }
    
    enum Inst: String {
        case mov
        case add
        case and
        case xor
        case jmp
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
    
    func add(_ dst: Reg, _ src: Int) {
        self.inst(.add, dst, src)
    }
    
    func add(_ dst: Reg, _ src: String) {
        self.inst(.add, dst, src)
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

    func syscall() {
        self.raw(Inst.syscall.rawValue)
    }
}
