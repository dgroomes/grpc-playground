import Foundation
import GRPC
import NIO

// A simple client-side program that makes a request to a gRPC 'echo' server.
@main
struct Runner {

    static func main() async {
        let group: MultiThreadedEventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let builder = ClientConnection.insecure(group: group)
        let connection = builder.connect(host: "localhost", port: 1234)

        let client = EchoAsyncClient(channel: connection)

        var request = Message()
        request.message = "Hello from a client-side Swift program!"

        let response: Message
        do {
            response = try await client.echo(request)
        } catch {
            print("Unexpected error while executing the 'echo' gRPC request: \(error)")
            return
        }

        print("Got response '\(response.message)'")
    }
}
