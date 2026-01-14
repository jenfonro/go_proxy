#!/bin/sh
set -eu

APP_DIR="/app"

# Seed module cache from the image into the mounted volume (avoids re-downloading on container start).
mkdir -p /go/pkg/mod /go/cache
if [ -d "/opt/gomodcache" ] && [ -z "$(ls -A /go/pkg/mod 2>/dev/null || true)" ]; then
  cp -a /opt/gomodcache/. /go/pkg/mod/ || true
fi

cd "$APP_DIR"
exec "$@"
