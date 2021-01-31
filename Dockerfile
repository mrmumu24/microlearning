FROM golang:1.15 AS builder

WORKDIR /microlearning
ADD . /microlearning
RUN make build

FROM alpine:3.13
COPY --from=builder /microlearning/cache .
ENTRYPOINT ["/microlearning"]
