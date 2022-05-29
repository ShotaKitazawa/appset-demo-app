# build stage
FROM golang:1.18 as builder
## init setting
WORKDIR /workdir
## download packages
COPY go.mod ./
RUN go mod download
## build
COPY . ./
RUN GOOS=linux go build -o app main.go

# run stage
FROM gcr.io/distroless/base
## copy binary
COPY --from=builder /workdir/app .
## Run
ENTRYPOINT ["./app"]

