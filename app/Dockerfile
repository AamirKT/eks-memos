FROM node:24-alpine@sha256:fb71d01345f11b708a3553c66e7c74074f2d506400ea81973343d915cb64eef0 AS frontend-builder
WORKDIR /app
RUN corepack enable && corepack prepare pnpm@9.15.4 --activate
COPY web/package.json web/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY web/ ./
RUN pnpm build

FROM golang:1.26-alpine@sha256:7a3e50096189ad57c9f9f865e7e4aa8585ed1585248513dc5cda498e2f41812c AS backend-builder
WORKDIR /app
RUN apk --no-cache add git
COPY go.mod go.sum ./
RUN go mod download
COPY . .
COPY --from=frontend-builder /app/dist ./server/router/frontend/dist
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w" -o bin/app ./cmd/memos

FROM alpine:3.21@sha256:48b0309ca019d89d40f670aa1bc06e426dc0931948452e8491e3d65087abc07d
LABEL build_test="true"
LABEL build_date="2026-07-02"
LABEL build_version="v0.0.1"
WORKDIR /app
RUN apk add --no-cache ca-certificates tzdata libc6-compat \
    && addgroup -S app \
    && adduser -S -G app -H -D app \
    && mkdir -p /var/opt/memos \
    && chown app:app /var/opt/memos
COPY --from=backend-builder /app/bin/app ./app
USER app
EXPOSE 8081
CMD ["./app"]