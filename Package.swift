// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dependencies",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Dependencies",
            type: .static,
            targets: ["Dependencies"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "3.6.0"),
        .package(url: "https://github.com/itsravenous/MySwift3Package.git", from: "1.0.0"),
        .package(url: "https://github.com/itsravenous/MySwift4Package.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Dependencies",
            dependencies: ["RxSwift", "MySwift3Package", "MySwift4Package"],
            path: ".deps-sources"
        )
    ]
)
