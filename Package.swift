// swift-tools-version: 6.0
import PackageDescription

let dependencies: [Target.Dependency] = [
    .product(name: "Algorithms", package: "swift-algorithms"),
    .product(name: "Collections", package: "swift-collections"),
    .product(name: "ArgumentParser", package: "swift-argument-parser"),
]

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-algorithms.git",
            .upToNextMajor(from: "1.2.0")),
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMajor(from: "1.0.0")),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.2.0")),
        .package(
            url: "https://github.com/apple/swift-format.git",
            .upToNextMajor(from: "509.0.0"))
    ],
    targets: [
        .executableTarget(
            name: "AdventOfCode",
            dependencies: dependencies,
            resources: [.copy("Data")]),
        .testTarget(
            name: "AdventOfCodeTests",
            dependencies: ["AdventOfCode"] + dependencies
        ),
        .plugin(name: "DayBump",
                capability: .command(intent: .custom(verb: "day-bump",
                                                     description: "Creates a day"),
                                     permissions: [
                                        .writeToPackageDirectory(reason: "This will create a new day")
                                     ]))
    ]
)
