# Makefile for building and pushing the test-image container

# Destination image (change if needed)
IMG ?= uhub.service.ucloud.cn/skyquakers/test-image:latest

# Value to embed in the binary; defaults to the current UNIX timestamp
BUILD_VALUE ?= $(shell date +%s)

# ---------- Targets ----------
.PHONY: all build push

# Default target
all: build

# Build the Docker image (linux/amd64) and load it into local Docker
build:
	docker buildx build \
	  --platform linux/amd64,linux/arm64 \
	  --build-arg BUILD_VALUE=$(BUILD_VALUE) \
	  -t $(IMG) \
	  --load \
	  .

# Build and push the image to registry in one step (linux/amd64 only)
push:
	docker buildx build \
	  --platform linux/amd64,linux/arm64 \
	  --build-arg BUILD_VALUE=$(BUILD_VALUE) \
	  -t $(IMG) \
	  --push \
	  . 