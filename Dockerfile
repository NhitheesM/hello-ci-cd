# Dockerfile
FROM rust:1.80 as builder

WORKDIR /usr/src/app
COPY . .

# Build the Rust binary
RUN cargo build --release

# ---- Runtime stage ----
FROM debian:bookworm-slim

WORKDIR /app

# Copy the compiled binary from builder
COPY --from=builder /usr/src/app/target/release/hello-ci-cd .

# Run the binary
CMD ["./hello-ci-cd"]
