# CHANGELOG

## 2.0.0 (pending)

- Rename `mapN` functions to `getN`.
  I think this reads better as "create a decoder that get's N fields from a row".
  It also makes it less awkward that it's deviating from the typical map API by having the mapper function last instead of first.
  It also gives me the name space to add a field-level `map` function.

## 1.1.0 (2024-04-26)

- Add `Db.errorToString`

## 1.0.1 (2024-04-22)

- Documentation fixes

## 1.0.0 (2024-04-22)

- Initial release
