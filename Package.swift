// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GRPCNIOTransportIssue",
    platforms: [
        .macOS("15.0")
    ],
    dependencies: [
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "2.1.2"),
        .package(url: "https://github.com/grpc/grpc-swift-nio-transport.git", from: "1.0.2"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.29.0"),
        .package(url: "https://github.com/grpc/grpc-swift-protobuf.git", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Client",
            dependencies: [
                .product(name: "GRPCNIOTransportHTTP2", package: "grpc-swift-nio-transport"),
                .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"),
                .target(name: "HelloWorldProto"),
            ]),

        .executableTarget(
            name: "Server",
            dependencies: [
                .product(name: "GRPCNIOTransportHTTP2", package: "grpc-swift-nio-transport"),
                .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"),
                .target(name: "HelloWorldProto"),
            ]),

        .target(
            name: "HelloWorldProto",
            dependencies: [
                .product(name: "GRPCCore", package: "grpc-swift"),
                .product(name: "GRPCProtobuf", package: "grpc-swift-protobuf"),
            ],
            resources: [
                .process("hello_world.protoset")
            ]
        )
    ]
)
