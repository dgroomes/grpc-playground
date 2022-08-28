// swift-tools-version:5.5

import PackageDescription

let package = Package(
        name: "swift",
        platforms: [
            .macOS(.v12)
        ],
        products: [
            .executable(name: "Client", targets: ["Client"]),
            .executable(name: "Server", targets: ["Server"]),
        ],
        dependencies: [
            .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.8.2")
        ],
        targets: [
            .executableTarget(
                    name: "Client",
                    dependencies: [.product(name: "GRPC", package: "grpc-swift")]),
            .executableTarget(
                    name: "Server",
                    dependencies: [.product(name: "GRPC", package: "grpc-swift")])
        ]
)
