test:
    just test-db & \
        npx --yes wait-on tcp:12321 && \
        fd .+\.gren | entr just build-and-run-tests

test-db:
    (rm tests/db/* || mkdir -p tests/db) && \
        npx --yes ws4sql --bind-host=localhost --quick-db=tests/db/test

build-and-run-tests:
    gren make && cd tests && gren make src/Main.gren && node app

