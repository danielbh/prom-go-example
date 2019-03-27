FROM golang:latest as builder
RUN mkdir /app
RUN mkdir /build
COPY go.mod go.sum main.go /app/
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o /build/main .

FROM golang:latest
COPY --from=builder /build/ /app/
EXPOSE 8080
USER        nobody
ENTRYPOINT  [ "/app/main" ]

