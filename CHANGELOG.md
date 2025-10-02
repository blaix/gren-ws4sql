# CHANGELOG

## 3.0.2 (2025-10-01)

- Include error message from server in Error values

## 3.0.1 (2025-09-24)

- Remove test dependencies from main package dependencies

## 3.0.0 (2025-09-10)

- Upgrade to Gren 0.6

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
