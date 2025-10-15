// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "simple-income-tax-calculator",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "simple-income-tax-calculator",
            targets: ["simple-income-tax-calculator"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.0")
    ],
    targets: [
        .executableTarget(
            name: "simple-income-tax-calculator",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "simple-income-tax-calculatorTests",
            dependencies: ["simple-income-tax-calculator"]
        )
    ]
)
