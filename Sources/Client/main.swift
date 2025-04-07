import GRPCNIOTransportHTTP2
import HelloWorldProto
import GRPCCore

try await withGRPCClient(
    transport: .http2NIOPosix(
        target: .dns(host: "example.com", port: 443),
        transportSecurity: .tls
    )
) { client in
    let helloWorldClient = Helloworld_Greeter.Client(wrapping: client)
    _ = try await helloWorldClient.sayHello(
        .with { $0.name = "World" }
    )
}
