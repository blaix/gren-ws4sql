# SQLite for Gren

Use sqlite entirely in [Gren](https://gren-lang.org/) without ports via [ws4sql](https://github.com/proofrock/ws4sqlite).

Note: this package expects the [ws4sql](https://github.com/proofrock/ws4sqlite/tree/fork/ws4sql) fork of ws4sqlite.
If you're using the [npm package](https://github.com/blaix/ws4sql-npm/), you're all set.
Otherwise, check the [github releases](https://github.com/proofrock/ws4sqlite/releases) of ws4sqlite for the latest ws4sql version (0.17.x).

## Usage Example

Start a ws4sql database server:

```bash
npx ws4sql --quick-db mydatabase.db
```

This will create `mydatabase.db` if it doesn't exist and start a server available at `http://localhost:12321/mydatabase`.

_See docs for [the npm package](https://github.com/blaix/ws4sql-npm/) and [ws4sql itself](https://github.com/proofrock/ws4sqlite/tree/fork/ws4sql) for details on running the server._

Then you can write code like:

```elm
import Db
import Db.Encode
import Db.Decode
import HttpClient

type alias User =
    { id : Int
    , name : String
    }

getUser : HttpClient.Permission -> Int -> Task Db.Error User
getUser httpPerm userId =
    let
        connection =
            Db.init httpPerm "http://localhost:12321/mydatabase"
    in
    Db.getOne connection
        { query = "select * from users where id = :id"
        , parameters = [ Db.Encode.int "id" userId ]
        , decoder = 
            Db.Decode.map2
                (Db.Decode.int "id")
                (Db.Decode.string "name")
                (\id name -> { id = id, name = name })
        }
```

See the [package docs](https://packages.gren-lang.org/package/blaix/gren-ws4sql) for full usage details.
