{ pkgs, lib, config, inputs, ... }:

{
  # See full reference at https://devenv.sh/reference/options/

  packages = [ 
    pkgs.entr
    pkgs.fd
    pkgs.nodejs_22
    pkgs.sqlite
  ];

  processes = {
    test-db.exec = "npx --yes ws4sql --bind-host localhost --quick-db ./tests/db/test.db";
    db-with-auth.exec = "npx --yes ws4sql --bind-host localhost --port 12322 --db ./tests/test-with-auth.yaml";
  };

  tasks = {
    "test:resetDbs" = { 
      before = [ "devenv:enterTest" ];
      exec = ''
        mkdir -p tests/db && \
        rm -f tests/db/* && \
        touch tests/db/test.log && \
        sqlite3 tests/db/test-with-auth.db "create table auth (user text, password text)" && \
        sqlite3 tests/db/test-with-auth.db "insert into auth (user, password) values (\"myuser\", \"mypass\")"
      '';
    };
  };

  enterTest = ''
    wait_for_port 12321 && \
    wait_for_port 12322 && \
    fd ".*\.(gren|js)" | entr -c -s 'gren make && cd tests && gren run Main'
  '';
}
