REVERSE_HOST=localhost
NGINX_PORT?=8000
URL=http://${REVERSE_HOST}:${NGINX_PORT}
FAILED=echo "❌"
OK=echo "✅"

FILE1=app-store-BrM1Qdjy.js
FILE2=app-store-3A5cQjTW.js
FILE3=app-store-CafL0y5z.js
TEST_RESPONSE=grep /assets/index

all: up wait env test

up:
	docker compose up --force-recreate --no-deps --build -d

build:
	docker build .

wait:
	@echo Wait
	sleep 3

test: test-version test-homepage test-fallbacks

test-fallback:
	@/bin/echo -n "Test /${PATH} - "
	@(curl -s ${URL}/${PATH} | ${TEST_RESPONSE} && ${OK}) || ${FAILED}

test-fallback-%: test-fallback
test-fallbacks: test-fallback-FILE1 test-fallback-FILE2 test-fallback-FILE3
PATH=$(@:test-fallback-%=%)
#	@if [ "${${*}}" = "" ]; then

test-homepage:
	curl ${URL}

test-version:
	curl ${URL}/version.txt

deps::
	npm install -g wscat

env:
	docker compose exec -it router env
