/*
 * This is client-side JavaScript code (Node.js) that calls a gRPC service on a remote port.
 */

let grpc = require('@grpc/grpc-js');
let {Message} = require('./generated/echo_pb');
let {EchoClient} = require('./generated/echo_grpc_pb');

let address = 'localhost:9090';
let credentials = grpc.credentials.createInsecure();
let echoClient = new EchoClient(address, credentials);

let message = new Message();
message.setMessage("Hello server, I am the client! Nice to meet you!");

console.log(`*Sending* the following message to the server:\n${message.getMessage()}\n`);
echoClient.echo(message, function (err, message) {
    if (err) {
        console.error(`The gRPC 'echo' method invocation failed.`, err);
        return;
    }

    console.log(`*Received* the following response from the server:\n${message.getMessage()}\n`);
});