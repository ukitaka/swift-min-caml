// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMinCaml",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
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
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftMinCaml",
            dependencies: ["SwiftParsec", "Tagged", "Curry"]),
        .testTarget(
            name: "SwiftMinCamlTests",
            dependencies: ["SwiftMinCaml"]),
    ]
)
