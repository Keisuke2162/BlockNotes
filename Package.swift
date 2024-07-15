// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlockNotes",
    platforms: [.iOS(.v17),],
    products: [
        .library(name: "RootFeature", targets: ["RootFeature"]),
        .library(name: "NoteFeature", targets: ["NoteFeature"]),
    ],
    dependencies: [
      // .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.11.2"),
    ],
    targets: [
      .target(name: "CustomView", dependencies: [
        "Entities",
      ]),
      .target(name: "Entities"),
      .target(name: "HomeFeature", dependencies: [
        "CustomView",
        "Entities",
      ]),
      .target(name: "NoteFeature", dependencies: [
        "Entities",
      ]),
      .target(name: "RootFeature", dependencies: [
        "HomeFeature",
        "Entities",
      ])
    ]
)
