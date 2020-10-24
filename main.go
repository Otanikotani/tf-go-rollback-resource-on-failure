package main

import (
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

type myEvent struct {
	Name string `json:"name"`
}

func handleRequest(ctx context.Context, name myEvent) (string, error) {
	fmt.Println("Hello world ok")
	return "{\"hello 1\": \"world\"}", nil
}

func main() {
	lambda.Start(handleRequest)
}
