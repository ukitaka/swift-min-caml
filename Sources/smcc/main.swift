import Foundation
import SwiftMinCamlKit

let p = ProcessInfo.processInfo
let input = (p.arguments.count > 1) ? p.arguments[1] : "1*2+3"
let output = Driver().run(input: input)
print(output)
