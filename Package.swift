// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlockNotes",
    products: [
        .library(
            name: "BlockNotes",
            targets: ["BlockNotes"]),
    ],
    targets: [
        .target(
            name: "BlockNotes"),
        .testTarget(
            name: "BlockNotesTests",
            dependencies: ["BlockNotes"]),
    ]
)
