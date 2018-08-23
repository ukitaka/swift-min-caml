# SwiftMinCaml

⚠️ 🏗Under construction ⚠️

MinCaml compiler written in Swift.

## Requirements

+ macOS, x86_64
+ swift 4.1
+ NASM

```
$ brew install nasm
```

## try! SwiftMinCaml

```
$ swift build
$ ./run.sh "1+2*3"
7
```

## For development

```
$ swift package generate-xcodeproj
```

You need to run `sourcery` when update `AST/AST.swift`, 

```
$ brew install sourcery
$ sourcery
```

and run `./generate_parser.sh` when update syntax file.

```
$ ./generate_parser.sh
```

