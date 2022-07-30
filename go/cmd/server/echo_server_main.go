package main

import (
	"context"
	"dgroomes/rpc"
	"fmt"
	"google.golang.org/grpc"
	"log"
	"net"
)

const (
	port = ":50051"
)

// server implements the "Echo" RPC server. I don't understand what the "Unimplemented..." types mean.
type server struct {
	rpc.UnimplementedEchoServer
}

// Echo implements the "echo" RPC method.
func (s *server) Echo(ctx context.Context, in *rpc.Message) (*rpc.Message, error) {
	msg := in.GetMessage()
	log.Println("Received: ", msg)

	echoString := fmt.Sprintf(`
%s...
%s...
%s...
`, msg, msg, msg)

	echoMessage := &rpc.Message{Message: echoString}

	return echoMessage, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}
	s := grpc.NewServer()
	rpc.RegisterEchoServer(s, &server{})
	log.Printf("Echo server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
