test:
    gren make && cd tests && gren make src/Main.gren && node app && gren docs

watch:
    fd ".+\.(js|ts|gren|json)" | entr -c just test
