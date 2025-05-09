# SQLite for Gren

Use sqlite entirely in [Gren](https://gren-lang.org/) without ports via [ws4sql](https://github.com/proofrock/ws4sqlite).

## Usage Example

Start a ws4sql database server (this will create the sqlite db if it doesn't exist):

```bash
npx ws4sql --quick-db /path/to/mydatabase.db
```

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
            Db.Decode.get2
                (Db.Decode.int "id")
                (Db.Decode.string "name")
                (\id name -> { id = id, name = name })
        }
```

## More Info

See the [package docs](https://packages.gren-lang.org/package/blaix/gren-ws4sql) for full usage details.

Running `npx ws4sql --quick-db` as in the example above lets you try out ws4sql without installing or configuring anything.
For full details on installing, configuring, and running ws4sql, see [the ws4sql-npm package](https://github.com/blaix/ws4sql-npm/) and [the ws4sqlite repo](https://github.com/proofrock/ws4sqlite).
Note: this package expects the [ws4sql fork of ws4sqlite](https://github.com/proofrock/ws4sqlite/tree/fork/ws4sql) (this is what is installed by the npm package).
