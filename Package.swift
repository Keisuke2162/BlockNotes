// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlockNotes",
    platforms: [.iOS(.v17),],
    products: [
        .library(name: "BlockNotes", targets: ["BlockNotes"]),
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
    ],
    dependencies: [
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.11.2"),
    ],
    targets: [
        .target(name: "BlockNotes"),
        .target(name: "Entities"),
        .target(name: "HomeFeature", dependencies: [
          "Entities",
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]),
        .testTarget(name: "BlockNotesTests", dependencies: ["BlockNotes"]),
    ]
)
