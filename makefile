SHELL = /bin/bash
export BUILD_HARNESS_PATH ?= $(shell until [ -d "build-harness" ] || [ "`pwd`" == '/' ]; do cd ..; done; pwd)/build-harness/
-include $(BUILD_HARNESS_PATH)/Makefile.shim

## Setup dev env
deps:
	yarn install

## Run test and lint once
test: lint test-chrome

## Test IE11 against local backend
test-ie:
	SERVICE=sauce BROWSER=ie11 yarn run test

## Run end to end tests on IE11
test-ie\:master:
	ORG=si-master SERVICE=sauce BROWSER=ie11 yarn run test:end-to-end-all-browsers

## Test Chrome against local backend
test-chrome:
	BROWSER=chrome yarn run test

## Test Chat
test-chat\:end-to-end:
	ORG=si-local-realBackend MULTIBROWSER=true yarn run test:chat

## Test Chat on master
test-chat\:master:
	ORG=si-master MULTIBROWSER=true yarn run test:chat

## Test Chat on staging
test-chat\:staging:
	ORG=si-staging MULTIBROWSER=true yarn run test:chat

## Run end to end tests on Chrome
test-chrome\:master:
	ORG=si-master BROWSER=chrome yarn run test:end-to-end-chrome

test-suite:
	-yarn run wdio --suite=${TEST_SUITE}

## Lint
lint:
	yarn run lint