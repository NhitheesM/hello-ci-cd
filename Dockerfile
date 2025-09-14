# ---- Build stage ----
FROM rust:1.80 AS builder

WORKDIR /usr/src/app

# Copy only Cargo.toml and Cargo.lock first
COPY Cargo.toml Cargo.lock ./

# Create an empty src to cache dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Build dependencies (caches layers)
RUN cargo build --release || true

# Now copy actual source code
COPY . .

# Rebuild with real source
RUN cargo build --release

# ---- Runtime stage ----
FROM debian:bullseye-slim AS runtime

WORKDIR /app
COPY --from=builder /app/target/release/hello-ci-cd /app/hello-ci-cd

# Run the binary
CMD ["./hello-ci-cd"]

