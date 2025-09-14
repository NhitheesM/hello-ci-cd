# ---- Builder stage ----
FROM rust:1.82 as builder
WORKDIR /app
COPY . .

# Build the Rust binary
RUN cargo build --release

# Debug: list the release directory
RUN ls -la /app/target/release
