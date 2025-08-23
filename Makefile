include .env
export

REVERSE_HOST=localhost
NGINX_PORT?=8000
URL=http://${REVERSE_HOST}:${NGINX_PORT}
FAILED=echo "❌"
OK=echo "✅"
CURL=/usr/bin/curl

TEST_RESPONSE=/usr/bin/grep ${PATH_TO_TEST} > /dev/null

all: up wait env test

up:
	docker compose up --force-recreate --no-deps --build -d

build:
	docker build .

wait:
	@echo Wait
	sleep 3

test: test-version test-homepage test-fallbacks

PATH_TO_TEST=${${*}}
test-fallback-%:
	@/bin/echo -n "Test fallback asset /${PATH_TO_TEST} - "
	@(${CURL} -s ${URL}/${PATH_TO_TEST} | ${TEST_RESPONSE} && ${OK}) || ${FAILED}

test-fallbacks: test-fallback-FILE1 test-fallback-FILE2 test-fallback-FILE0

test-homepage:
	@/bin/echo -n "Test home page - "
	@(${CURL} -s ${URL} > /dev/null && ${OK}) || ${FAILED}

test-version:
	@/bin/echo -n "Test version - "
	@(${CURL} -s ${URL}/version.txt > /dev/null && ${OK}) || ${FAILED}

deps::
	npm install -g wscat

env:
	docker compose exec -it router env
