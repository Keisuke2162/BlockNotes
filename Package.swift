// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlockNotes",
    platforms: [.iOS(.v17),],
    products: [
        .library(name: "BlockNotes", targets: ["BlockNotes"]),
    ],
    dependencies: [
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.1"),
    ],
    targets: [
        .target(name: "BlockNotes"),
        .target(name: "Entities"),
        .target(name: "HomeFeature", dependencies: ["Entities"]),
        .testTarget(name: "BlockNotesTests", dependencies: ["BlockNotes"]),
    ]
)
