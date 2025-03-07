test:
    mkdir -p tests/db && \
        gren make && cd tests && gren make src/Main.gren && \
        npx concurrently --kill-others --names db,tests \
            "npx ws4sql --bind-host=localhost --quick-db=db/test" \
            "npx wait-on tcp:12321 && node app" && \
        gren docs

watch:
    fd ".+\.(js|ts|gren|json)" | entr -c just test
