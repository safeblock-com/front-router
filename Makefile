REVERSE_HOST=localhost
NGINX_PORT?=8000
URL=http://${REVERSE_HOST}:${NGINX_PORT}
FAILED=echo "❌"
OK=echo "✅"
CURL=/usr/bin/curl

FILE1=app-store-BrM1Qdjy.js
FILE2=app-store-3A5cQjTW.js
FILE3=app-store-CafL0y5z.js
TEST_RESPONSE=/usr/bin/grep /assets/index > /dev/null

all: up wait test

up:
	docker compose up --force-recreate --no-deps --build -d

build:
	docker build .

wait:
	@echo Wait
	sleep 3

test: test-version test-homepage test-fallbacks

test-fallback-%:
	@/bin/echo -n "Test fallback asset /${PATH_TO_TEST} - "
	@(${CURL} -s ${URL}/${PATH_TO_TEST} | ${TEST_RESPONSE} && ${OK}) || ${FAILED}

# test-fallbacks: test-fallback-FILE1 test-fallback-FILE2 test-fallback-FILE3
test-fallbacks: test-fallback-FILE1 test-fallback-FILE2 test-fallback-FILE3

#PATH_TO_TEST=$(@:test-fallback-%=%)
PATH_TO_TEST=${${*}}

#test-fallback-%: test-fallback
	#@echo ${PATH_TO_TEST}
	## test-fallback

test-homepage:
	@/bin/echo -n "Test home page - "
	@(${CURL} -s ${URL} > /dev/null && ${OK}) || ${FAILED}

test-version:
	@/bin/echo -n "Test version - "
	@(${CURL} -s ${URL}/version.txt > /dev/null && ${OK}) || ${FAILED}

deps::
	npm install -g wscat
