// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMinCaml",
    products: [
        .executable(
            name: "smcc",
            targets: ["smcc"]),
        .library(
            name: "SwiftMinCaml",
            targets: ["SwiftMinCaml"]),
    ],
    dependencies: [
        .package(url: "git@github.com:davedufresne/SwiftParsec.git", from: "3.0.0"),
        .package(url: "git@github.com:pointfreeco/swift-tagged.git", from: "0.1.0"),
        .package(url: "git@github.com:thoughtbot/Curry.git", from: "4.0.1"),
    ],
    targets: [
        .target(
            name: "smcc",
            dependencies: ["SwiftMinCaml"]),
        .target(
            name: "SwiftMinCaml",
            dependencies: ["SwiftParsec", "Tagged", "Curry"]),
        .testTarget(
            name: "SwiftMinCamlTests",
            dependencies: ["SwiftMinCaml"]),
    ]
)
