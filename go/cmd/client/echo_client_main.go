package main

import (
	"context"
	"dgroomes/rpc"
	"google.golang.org/grpc"
	"log"
	"os"
	"time"
)

const (
	address = "localhost:50051"
)

func main() {
	// Set up a connection to the server.
	conn, err := grpc.Dial(address, grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		log.Fatalf("Failed to connect: %v", err)
	}
	defer conn.Close()

	client := rpc.NewEchoClient(conn)

	var messageString string
	if len(os.Args) > 1 {
		messageString = os.Args[1]
	} else {
		log.Fatal("Please supply a message to send to the echo server.")
	}

	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	log.Println("Sending message: ", messageString)
	r, err := client.Echo(ctx, &rpc.Message{Message: messageString})
	if err != nil {
		log.Fatalf("Failed to send a message to the echo server: %v", err)
	}

	log.Printf("Received response: %s", r.GetMessage())
}
