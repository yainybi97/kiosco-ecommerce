package main

import (
	"context"
	"fmt"
	"log"

	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context) (string, error) {
	log.Println("✅ Lambda ejecutada correctamente - Hello from the log!")
	return "Hello, world!", nil
}

func main() {
	fmt.Println("🚀 Iniciando Lambda")
	lambda.Start(handler)
}
