import GRPCNIOTransportHTTP2
import HelloWorldProto
import GRPCCore

struct HelloWorldService: Helloworld_Greeter.SimpleServiceProtocol {
    func sayHello(request: Helloworld_HelloRequest, context: ServerContext) async throws -> Helloworld_HelloReply {
        return .with {
            $0.message = "Hello, \(request.name)!"
        }
    }
}

let server = GRPCServer(transport: .http2NIOPosix(
    address: .ipv4(host: "127.0.0.1", port: 8080),
    transportSecurity: .plaintext
), services: [
    HelloWorldService()
])

print("Starting server...")
try await server.serve()
