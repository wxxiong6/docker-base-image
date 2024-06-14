FROM go:1.20-alpine-git AS builder

ARG BUILD_DIR=./app/cvs/test/cmd/test
ARG RELEASE_TAG
ARG SERVICE_NAME

WORKDIR /build

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 \
	GOPROXY="https://goproxy.cn,direct"

COPY go.mod go.sum .

RUN go mod download



COPY . .
	
RUN adduser -u 10001 -D app-runner && GOOS=linux CGO_ENABLED=0 GOARCH=amd64 go build -ldflags "-w -s  -X main.Version=${RELEASE_TAG} -X main.Name=${SERVICE_NAME}"   -a -o /bin/app ${BUILD_DIR}

FROM alpine:3.17 AS final

WORKDIR /app

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /bin/app /app/

USER app-runner

EXPOSE 8000
EXPOSE 9000

VOLUME /app/conf

ENTRYPOINT ["/app/app", "-conf", "/app/conf/"]
