// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]
        ),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(url: "https://github.com/realm/realm-swift.git", exact: "10.39.1")
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                "Domain",
                .product(
                    name: "RealmSwift",
                    package: "realm-swift"
                )
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]
        ),
    ]
)
