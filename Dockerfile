# ---------- Stage 1: Builder ----------
FROM rust:1.82 as builder
WORKDIR /app

RUN apt-get update && apt-get install -y musl-tools && rustup target add x86_64-unknown-linux-musl

COPY Cargo.toml Cargo.lock ./
COPY src ./src

# Build static binary
RUN cargo build --release --target x86_64-unknown-linux-musl

# ---------- Stage 2: Runtime ----------
FROM alpine:3.20 as runtime
WORKDIR /app

# Copy the static binary
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/hello-ci-cd /app/hello-ci-cd

CMD ["./hello-ci-cd"]
