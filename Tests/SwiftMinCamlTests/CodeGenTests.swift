//
//  CodeGenTests.swift
//  SwiftMinCamlTests
//
//  Created by Yuki Takahashi on 2018/06/17.
//

import XCTest
@testable import SwiftMinCamlKit

class CodeGenTest: XCTestCase {
    func parse(input: String) -> Expr {
        let parser = Parser()
        try! lexer.tokenize(input) { (t, c) in
            try! parser.consume(token: t, code: c)
        }
        let expr = try! parser.endParsing()
        return expr
    }
    

    func testArithOps() {
//        let input = "1+2*3"
//        let exp = parse(input: input)
//        let asm = CodeGen().gen(expr: exp)
//        let expected = """
//        extern print_int
//        global start
//        section .text
//        start:
//        and rsp, -16
//        mov rax, 3
//        mov rdi, 2
//        mul rdi
//        mov rdi, 1
//        add rax, rdi
//        mov rdi, rax
//        sub rsp, -16
//        call print_int
//        add rsp, 16
//        jmp mincaml_exit
//        mincaml_exit:
//        mov rax, 1
//        add rax, 0x2000000
//        xor rdi, rdi
//        syscall
//
//        """
//        XCTAssertEqual(asm, expected)
    }
}
