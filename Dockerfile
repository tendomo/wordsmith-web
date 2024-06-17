# Use a slim alpine image with Golang pre-installed
FROM golang:1.21-alpine AS builder

# Set working directory
WORKDIR /app

# Copy the application code
COPY . .

RUN apk add --no-cache golang1.22.4

# Install dependencies
RUN go mod download

# Build the application (replace main.go with your actual entrypoint)
RUN go build -o main ./

# Use a smaller alpine image for the final image
FROM alpine:latest

# Copy the built binary
COPY --from=builder /app/main /app/main

# Set the working directory
WORKDIR /app

# Expose port 8080 (you can change this to your desired port)
EXPOSE 8080

# Run the application on startup
CMD ["./main"]
