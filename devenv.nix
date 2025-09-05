{ pkgs, lib, config, inputs, ... }:

{
  # See full reference at https://devenv.sh/reference/options/

  packages = [ 
    pkgs.entr
    pkgs.fd
    pkgs.gren
    pkgs.nodejs_22
    pkgs.sqlite
  ];

  processes = {
    test-db.exec = "npx --yes ws4sql --bind-host localhost --quick-db ./test-dbs/test.db";
    db-with-auth.exec = "npx --yes ws4sql --bind-host localhost --port 12322 --db ./test-dbs/test-with-auth.yaml";
  };

  tasks = {
    "test:resetDbs" = { 
      before = [ "devenv:enterTest" ];
      exec = ''
        rm -f test-dbs/*.db && \
        rm -f test-dbs/*.log && \
        touch test-dbs/test.log && \
        sqlite3 test-dbs/test-with-auth.db "create table auth (user text, password text)" && \
        sqlite3 test-dbs/test-with-auth.db "insert into auth (user, password) values (\"myuser\", \"mypass\")"
      '';
    };
  };

  enterTest = ''
    wait_for_port 12321 && \
    wait_for_port 12322 && \
    fd ".*\.gren" | entr -c -s 'gren make && gren run Tests'
  '';
}
