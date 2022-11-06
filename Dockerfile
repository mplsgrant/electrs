# Important: This file is provided for demonstration purposes and may NOT be suitable for production use.
# The maintainers of electrs are not deeply familiar with Docker, so you should DYOR.
# If you are not familiar with Docker either it's probably be safer to NOT use it.

FROM debian:testing-slim as base
RUN apt-get update -qqy
RUN apt-get install -qqy curl

### Electrum Rust Server ###
FROM rust:1.60-slim as electrs-build
RUN apt-get update -qqy
RUN apt-get install -qqy clang cmake build-essential

# Install electrs
WORKDIR /build/electrs
COPY . .
RUN cargo install --locked --path .

FROM base as result
# Copy the binaries
COPY --from=electrs-build /usr/local/cargo/bin/electrs /usr/bin/electrs

WORKDIR /
