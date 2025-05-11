# CHANGELOG

## 2.0.0 (2025-05-11)

This release is an overhaul of the `Decode` module:

- `Decoder` and `FieldDecoder` are merged into a single type.
- `mapN` functions renamed to `getN` since they have a different API than what's typical for map functions.
- `map` added and works like a normal map function.
- added `succeed`, `fail`, and `andThen`

## 1.1.0 (2025-04-26)

- Add `Db.errorToString`

## 1.0.1 (2025-04-22)

- Documentation fixes

## 1.0.0 (2025-04-22)

- Initial release
