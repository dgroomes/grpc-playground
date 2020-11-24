package dgroomes;

import io.grpc.Channel;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;

import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

/**
 * Simple Java program that creates a gRPC client and communicates to a remote gRPC server.
 */
public class ClientMain {

    private static final Logger log = Logger.getLogger(ClientMain.class.getName());

    public static void main(String[] args) throws InterruptedException {
        ManagedChannel managedChannel = ManagedChannelBuilder
                .forTarget("localhost:9090")
                .usePlaintext()
                .build();

        try {
            sendRequest(managedChannel);
        } finally {
            managedChannel.shutdownNow().awaitTermination(5, TimeUnit.SECONDS);
        }
    }

    /**
     * Send a request to the gRPC server
     */
    private static void sendRequest(Channel managedChannel) {
        EchoGrpc.EchoBlockingStub stub = EchoGrpc.newBlockingStub(managedChannel);

        var message = "Hello server, I am a Java-based client! Nice to meet you!";
        log.info("*Sending* the following message to the server:\n%s\n".formatted(message));
        EchoProtos.Message request = EchoProtos.Message.newBuilder().setMessage(message).build();
        EchoProtos.Message response = stub.echo(request);

        log.info("*Received* the following response from the server:\n%s\n".formatted(response.getMessage()));
    }
}
