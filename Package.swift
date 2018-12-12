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
            name: "SwiftMinCamlKit",
            targets: ["SwiftMinCamlKit"]),
    ],
    dependencies: [
        .package(url: "git@github.com:pointfreeco/swift-tagged.git", from: "0.1.0"),
        .package(url: "git@github.com:thoughtbot/Curry.git", from: "4.0.1"),
        .package(url: "git@github.com:ukitaka/citron.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "smcc",
            dependencies: ["SwiftMinCamlKit"]),
        .target(
            name: "SwiftMinCamlKit",
            dependencies: ["CitronKit", "Tagged", "Curry"]),
        .testTarget(
            name: "SwiftMinCamlTests",
            dependencies: ["SwiftMinCamlKit"]),
    ]
)
