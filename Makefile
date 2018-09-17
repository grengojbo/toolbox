#
# Makefile for this application
#

OK_COLOR=\033[32;01m
NO_COLOR=\033[0m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

REPO_URL ?= grengojbo
TAG=$(shell cat RELEASE)

OSNAME=$(shell uname)

CUR_TIME=$(shell date '+%Y-%m-%d_%H:%M:%S')
# Program version
VERSION=$(shell cat RELEASE)

# Binary name for bintray
BIN_NAME=$(shell basename $(abspath ./))

# Project name for bintray
PROJECT_NAME=$(shell basename $(abspath ./))
PROJECT_DIR=$(shell pwd)

# Project url used for builds
# examples: github.com, bitbucket.org
REPO_HOST_URL=github.com.org

# Grab the current commit
GIT_COMMIT="$(shell git rev-parse HEAD)"


default: help

help:
	@echo "..............................................................."
	@echo "Project: $(PROJECT_NAME) | current dir: $(PROJECT_DIR)"
	@echo "version: $(VERSION)\n"
	@echo "make build    - Build Docker image"
	@echo "make push     - Push Docker image"
	@echo "make clean    - Clean local Docker image"
	@echo "...............................................................\n"


clean:
	docker rmi -f $(REPO_URL)/$(PROJECT_NAME):$(TAG)
	docker system prune -f

push:
	docker push $(REPO_URL)/$(PROJECT_NAME):$(TAG)

build:
	docker build --tag=$(REPO_URL)/$(PROJECT_NAME):$(TAG) .

# Attach a root terminal to an already running dev shell
shell:
	docker run -it --rm $(REPO_URL)/$(PROJECT_NAME):$(TAG) zsh

version:
	@echo ${VERSION}
