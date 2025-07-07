# -------- Build stage --------
FROM golang:1.22-alpine AS builder

# Optional build-time value; can be overridden with --build-arg
ARG BUILD_VALUE="build_time_value_not_set"

WORKDIR /app

# Copy go modules files first to leverage Docker cache
COPY go.mod .
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build with injected value
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w -X main.BuildValue=${BUILD_VALUE}" -o /app/test-image

# -------- Runtime stage --------
FROM alpine:3.19

# Set non-root user (optional)
# RUN adduser -D appuser
# USER appuser

# Copy binary from builder stage
COPY --from=builder /app/test-image /usr/local/bin/test-image

# Default command prints the build value then sleeps forever
CMD ["/usr/local/bin/test-image"] 