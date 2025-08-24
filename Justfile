test:
    just test-dbs & \
        npx --yes wait-on tcp:12321 && \
        npx --yes wait-on tcp:12322 && \
        fd .+\.gren | entr just build-and-run-tests

test-dbs:
    rm -f test-dbs/*.db && \
    rm -f test-dbs/*.log && \
    touch test-dbs/test.log && \
    sqlite3 test-dbs/test-with-auth.db "create table auth (user text, password text)" && \
    sqlite3 test-dbs/test-with-auth.db "insert into auth (user, password) values (\"myuser\", \"mypass\")" && \
    npx --yes ws4sql --bind-host localhost --quick-db ./test-dbs/test.db & \
    npx --yes ws4sql --bind-host localhost --port 12322 --db ./test-dbs/test-with-auth.yaml

build-and-run-tests:
    gren run Test

