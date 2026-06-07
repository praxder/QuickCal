// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "QuickCal",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .executable(name: "QuickCal", targets: ["QuickCalApp"])
  ],
  targets: [
    .executableTarget(
      name: "QuickCalApp",
      exclude: ["Info.plist"],
      linkerSettings: [
        .unsafeFlags([
          "-Xlinker", "-sectcreate",
          "-Xlinker", "__TEXT",
          "-Xlinker", "__info_plist",
          "-Xlinker", "Sources/QuickCalApp/Info.plist",
        ])
      ]
    ),
    .testTarget(
      name: "QuickCalAppTests",
      dependencies: ["QuickCalApp"]
    ),
  ]
)
