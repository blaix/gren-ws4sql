test:
    mkdir -p tests/db && \
        npx concurrently --names db,tests \
            "npx ws4sql --bind-host=localhost --quick-db=tests/db/test" \
            "npx wait-on tcp:12321 && fd .+\.gren | entr just build-and-run-tests"

build-and-run-tests:
    gren make && cd tests && gren make src/Main.gren && node app
