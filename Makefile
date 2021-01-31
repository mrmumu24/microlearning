TAG:=$(shell git describe --tags --abbrev=0)

.PHONY: build
build:
	CGO_ENABLED=0 go build -o ./cache/microlearning

.PHONY: lint
lint:
	docker run --rm -v $(pwd):/app \
		-w /app golangci/golangci-lint:v1.30.0 \
		golangci-lint run -v

.PHONY: tests
tests:
	go test -v -race \
		-covermode atomic \
		-coverprofile coverage.out \
		./... -json > report.json 
	go tool cover -func coverage.out

.PHONY: run
run:
	./cache/microlearning

.PHONY: clean
clean:
	rm -r cache/
	rm coverage.out report.json

.PHONY: image
image:
	docker build -t mrmumu24/microlearning:$(TAG) . 
