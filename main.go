package main

import (
	"context"
	"github.com/aws/aws-lambda-go/lambda"
)

type myEvent struct {
	Name string `json:"name"`
}

func handleRequest(ctx context.Context, name myEvent) (string, error) {
	return "{\"hello\": \"world\"}", nil
}

func main() {
	lambda.Start(handleRequest)
}
