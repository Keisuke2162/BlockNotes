// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlockNotes",
    platforms: [.iOS(.v17),],
    products: [
        .library(name: "RootFeature", targets: ["RootFeature"]),
        .library(name: "NoteFeature", targets: ["NoteFeature"]),
        .library(name: "Entities", targets: ["Entities"]),
        .library(name: "SettingsFeature", targets: ["SettingsFeature"]),
    ],
    dependencies: [
      // .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.11.2"),
    ],
    targets: [
      .target(name: "CustomView", dependencies: [
        "Entities",
      ]),
      .target(name: "Entities"),
      .target(name: "Extensions"),
      .target(name: "HomeFeature", dependencies: [
        "CustomView",
        "Entities",
        "NoteFeature",
        "SettingsFeature",
      ]),
      .target(name: "NoteFeature", dependencies: [
        "Entities",
        "Extensions",
      ]),
      .target(name: "RootFeature", dependencies: [
        "HomeFeature",
        "Entities",
      ]),
      .target(name: "SettingsFeature"),
    ]
)
