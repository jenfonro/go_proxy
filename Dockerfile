# syntax=docker/dockerfile:1

FROM golang:1.22-bookworm AS deps
WORKDIR /opt/app

COPY go.mod go.sum ./
RUN go mod download


FROM golang:1.22-bookworm
WORKDIR /app

ENV PORT=3010 \
  GOMODCACHE=/go/pkg/mod \
  GOCACHE=/go/cache

COPY --from=deps /go/pkg/mod /opt/gomodcache
COPY docker-entrypoint.sh /usr/local/bin/goproxy-entrypoint
RUN chmod +x /usr/local/bin/goproxy-entrypoint \
  && mkdir -p /go/pkg/mod /go/cache

EXPOSE 3010
VOLUME ["/go/pkg/mod", "/go/cache"]

ENTRYPOINT ["/usr/local/bin/goproxy-entrypoint"]
CMD ["sh", "-lc", "go run ."]
