//
//  CodeGen.swift
//  SwiftMinCaml
//
//  Created by Yuki Takahashi on 2018/06/13.
//

struct CodeGen {
    let builder = NasmX64Builder()
    let startLabel = "start"

    func gen(expr: Expr) -> String {
        builder.raw("global \(startLabel)")
        builder.section(.text)
        builder.globalLabel(startLabel)
        return builder.code
    }
}

class NasmX64Builder {
    enum Reg: String {
        case rax
        case rcx
    }
    
    enum Section: String {
        case data
        case text
    }
    
    enum Inst {
        case movq
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
    
    func inst(_ inst: Inst, _ dst: Reg, _ src: Reg) {
        self.raw("\(inst) \(dst), \(src)")
    }
    
    func globalLabel(_ label: String) {
        self.raw("\(label):")
    }

    func movq(_ dst: Reg, src: Reg) {
        self.inst(.movq, dst, src)
    }
}
