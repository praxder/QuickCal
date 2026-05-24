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
      name: "QuickCalApp"
    ),
    .testTarget(
      name: "QuickCalAppTests",
      dependencies: ["QuickCalApp"]
    ),
  ]
)
