FROM golang as builder
RUN mkdir /build
ADD ./main.go /build/
WORKDIR /build
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .

FROM scratch
EXPOSE 2112
COPY --from=builder /build /app/
WORKDIR /app
CMD ["./main"]

