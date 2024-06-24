FROM golang:alpine as builder
WORKDIR /usr/local/app

COPY dispatcher.go .

# build for the target arch not the build platform host arch
RUN go build dispatcher.go

# RUN
# defaults to using the target arch image
FROM alpine:latest
WORKDIR /usr/local/app

COPY --from=builder /usr/local/app/dispatcher ./
COPY static ./static/

EXPOSE 80
CMD ["/usr/local/app/dispatcher"]