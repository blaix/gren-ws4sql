test:
    just test-dbs & \
        npx --yes wait-on tcp:12321 && \
        npx --yes wait-on tcp:12322 && \
        fd .+\.gren | entr just build-and-run-tests

test-dbs:
    rm -f tests/db/*.db && \
    rm -f tests/db/*.log && \
    touch tests/db/test.log && \
    sqlite3 tests/db/test-with-auth.db "create table auth (user text, password text)" && \
    sqlite3 tests/db/test-with-auth.db "insert into auth (user, password) values (\"myuser\", \"mypass\")" && \
    npx --yes ws4sql --bind-host localhost --quick-db ./tests/db/test.db & \
    npx --yes ws4sql --bind-host localhost --port 12322 --db ./tests/db/test-with-auth.yaml

build-and-run-tests:
    gren make && cd tests && gren make src/Main.gren && node app

