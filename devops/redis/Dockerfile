FROM golang:1.20.0-alpine3.17 AS builder

ARG BUILD_DIR=./
ARG RELEASE_TAG=1.0
ARG SERVICE_NAME=redisTool

WORKDIR /build

#创建app-runner用户, -D表示无密码
RUN adduser -u 10001 -D app-runner

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
	GOPROXY="https://goproxy.cn,direct"

ENV ENV_ADDR="" \
    ENV_ISOUTPUT=false \
    ENV_FILENAME="keys.txt" \
    ENV_INTERVAL="50ms" \
    ENV_EXPIRE="-1s"  \
    ENV_MATCH="*"

COPY go.mod .
COPY go.sum .
RUN go mod download
COPY main.go .


RUN GOOS=linux CGO_ENABLED=0 GOARCH=amd64 go build -ldflags "-w -s  -X main.Version=${RELEASE_TAG} -X main.Name=${SERVICE_NAME}"   -a -o /bin/app ${BUILD_DIR}

FROM alpine:3.17 AS final

WORKDIR /app

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /bin/app /app/

USER app-runner




ENTRYPOINT ["/app/app", "-addr", "{$ENV_ADDR}", "-isOutput", "{$ENV_ISOUTPUT}", "-filename", "{$ENV_FILENAME}", "-interval", "{$ENV_INTERVAL}",  "-expire", "{$ENV_EXPIRE}", "-match", "{$ENV_MATCH}"]
