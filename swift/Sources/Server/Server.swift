import GRPC
import NIOCore
import SwiftProtobuf
import Foundation
import GRPC
import NIO

public class EchoProviderImpl: EchoProvider {

    public var interceptors: EchoServerInterceptorFactoryProtocol?

    public func echo(request: Message, context: StatusOnlyCallContext) -> EventLoopFuture<Message> {
        var responseMessage: Message = Message()

        // Echo the incoming message by repeating it a few times, like you literally shouted into a big room and
        // could hear your voice echo.
        let echoedMessage = "\(request.message)... \(request.message)... \(request.message)"

        responseMessage.message = echoedMessage

        return context.eventLoop.makeSucceededFuture(responseMessage)
    }
}

// Note: we need a `@main`-annotated struct instead of a `main.swift` file because it appears that you can't do top-level
// await in `main.swift` from what I can tell. That's fine and it's pretty interesting.
@main
struct Runner {
    static func main() async {
        let group: MultiThreadedEventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        defer {
            do {
                try group.syncShutdownGracefully()
            } catch {
                print("Unexpected error while shutting down the event loop group: \(error)")
            }
        }

        let builder: Server.Builder = Server.insecure(group: group)

        let server: Server
        do {
            server = try await builder.withServiceProviders([EchoProviderImpl()])
                    .bind(host: "localhost", port: 1234)
                    .get()

            print("Started gRPC echo server at \(server.channel.localAddress!)")
        } catch {
            print("Unexpected error while starting the gRPC server: \(error)")
            return
        }

        do {
            // Keep the process alive indefinitely. It's up to you to kill the process from the commandline to stop the
            // program when you so desire.
            try await server.onClose.get()
        } catch {
            print("Unexpected error while running the gRPC server: \(error)")
        }
    }
}
