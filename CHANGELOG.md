# Changelog

All notable changes to the DynaType package will be documented in this file.

## 2.0.0

- Major restructuring of the package.
- Simplified the validation process, now done via a single `DynaValidator` class.
- Introduced a more flexible schema definition using `Map<String, List<DynaType>>`.
- Enhanced error handling, now throwing `FormatException` on missing or incorrect fields and invalid JSON data.
- Added detailed comments to the `DynaType` and `DynaValidator` classes.

## 1.0.7

- Solved issue of getting `Map<String, Null>` data type.

## 1.0.6

- Fixed all known issues.

## 1.0.5

- Bug fixes.

## 1.0.4

- Made major changes in map comparison logic.

## 1.0.3

- Updated `README.md`.

## 1.0.2

- Bug fixes.
- Made major type changes.
- Updated example.

## 1.0.1

- Bug fixes.
- Added example.

## 1.0.0

- Initial version.
