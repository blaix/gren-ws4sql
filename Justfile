test:
    just test-db & \
        npx wait-on tcp:12321 && \
        fd .+\.gren | entr just build-and-run-tests

test-db:
    mkdir -p tests/db && \
        npx ws4sql --bind-host=localhost --quick-db=tests/db/test

build-and-run-tests:
    gren make && cd tests && gren make src/Main.gren && node app

