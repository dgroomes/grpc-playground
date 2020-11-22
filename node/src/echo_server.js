/*
 * This is server-side JavaScript code (Node.js) that runs a gRPC server
 */

let {Server, ServerCredentials} = require('@grpc/grpc-js');
let {Message} = require('./generated/echo_pb');
let {EchoService} = require('./generated/echo_grpc_pb');

/**
 * This function is an implementation for the RPC method named "echo" that is defined in the Protobuf definition file
 * "echo.proto"
 *
 * Echo the message back
 * Echoes go like "echo... echo... echo..."! Get it?
 */
function echo(call, callback) {
    console.log("Got a request! Echoing it right back to the client...");

    let receivedMessage = call.request.getMessage();
    let responseMessage = new Message();

    responseMessage.setMessage(`${receivedMessage}...\n${receivedMessage}...\n${receivedMessage}...`);
    callback(null, responseMessage);
}

/**
 * 1. Start a gRPC server
 * 2. Glue the implementation to the interface. Specifically, glue our RPC implementation function named "echo" to the
 *    code-generated "EchoService" gRPC service which defines an (interface) method of the same name ("echo").
 * 3. Listen for requests on a port indefinitely
 */
let server = new Server();
server.addService(EchoService, {echo: echo});
server.bindAsync('0.0.0.0:9090', ServerCredentials.createInsecure(), () => {
    console.log("Listening for requests...");
    server.start();
});
