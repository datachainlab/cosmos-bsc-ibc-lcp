ARG GO_VERSION="1.23.2"
ARG ALPINE_VERSION="3.20"

# --------------------------------------------------------
# Builder
# --------------------------------------------------------

FROM golang:${GO_VERSION}-alpine${ALPINE_VERSION} AS builder

# Always set by buildkit
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETOS
ARG XIOND_BINARY

# needed in makefile
ARG COMMIT
ARG VERSION

# Consume Args to env
ENV COMMIT=${COMMIT} \
    VERSION=${VERSION} \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    XIOND_BINARY=${XIOND_BINARY}

# Install dependencies
RUN set -eux; \
    apk add --no-cache \
    build-base \
    ca-certificates \
    linux-headers \
    binutils-gold \
    git \
    jq \
    bash

# Set the workdir
COPY . /root/
WORKDIR /root

# Download go dependencies
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/root/pkg/mod \
    set -eux; \
    go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0; \
    go mod download

# Cosmwasm - Download correct libwasmvm version
RUN set -eux; \
    WASMVM_REPO="github.com/CosmWasm/wasmvm"; \
    WASMVM_MOD_VERSION="$(grep ${WASMVM_REPO} go.mod | cut -d ' ' -f 1)"; \
    WASMVM_VERSION="$(go list -m ${WASMVM_MOD_VERSION} | cut -d ' ' -f 2)"; \
    [ ${TARGETPLATFORM} = "linux/amd64" ] && LIBWASM="libwasmvm_muslc.x86_64.a"; \
    [ ${TARGETPLATFORM} = "linux/arm64" ] && LIBWASM="libwasmvm_muslc.aarch64.a"; \
    [ ${TARGETOS} = "darwin" ] && LIBWASM="libwasmvmstatic_darwin.a"; \
    [ -z "$LIBWASM" ] && echo "Arch ${TARGETARCH} not recognized" && exit 1; \
    wget "https://${WASMVM_REPO}/releases/download/${WASMVM_VERSION}/${LIBWASM}" -O "/lib/${LIBWASM}"; \
    # verify checksum
    EXPECTED=$(wget -q "https://${WASMVM_REPO}/releases/download/${WASMVM_VERSION}/checksums.txt" -O- | grep "${LIBWASM}" | awk '{print $1}'); \
    sha256sum "/lib/${LIBWASM}" | grep "${EXPECTED}"; \
    cp /lib/${LIBWASM} /lib/libwasmvm_muslc.a;

# Build xiond binary
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/root/pkg/mod \
    if [ -e "${XIOND_BINARY:-}" ]; then \
        cp "${XIOND_BINARY}" /go/bin/xiond; \
    else \
        export CGO_ENABLED=1 LINK_STATICALLY=true BUILD_TAGS=muslc; \
        make test-version; \
        make install; \
    fi

WORKDIR /root/app

ARG CHAINID
ARG CHAINDIR=/root/data
ARG RPCPORT=26657
ARG P2PPORT=26656
ARG PROFPORT=6060
ARG GRPCPORT=9090

RUN bash tm-chain xiond $CHAINID $CHAINDIR $RPCPORT $P2PPORT $PROFPORT $GRPCPORT

ENV CHAINID=$CHAINID 
ENV CHAINDIR=$CHAINDIR
EXPOSE $RPCPORT $P2PPORT $PROFPORT $GRPCPORT
ENTRYPOINT ["./entrypoint.sh"]
