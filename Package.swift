// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlockNotes",
    platforms: [.iOS(.v17),],
    products: [
        .library(name: "RootFeature", targets: ["RootFeature"]),
    ],
    dependencies: [
      // .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.11.2"),
    ],
    targets: [
      .target(name: "BlockItemFeature", dependencies: [
        "Entities",
      ]),
      .target(name: "CustomView", dependencies: [
        "BlockItemFeature",
        "Entities",
      ]),
      .target(name: "Entities"),
      .target(name: "HomeFeature", dependencies: [
        "BlockItemFeature",
        "CustomView",
        "Entities",
      ]),
      .target(name: "RootFeature", dependencies: [
        "HomeFeature",
        "Entities",
      ])
    ]
)
