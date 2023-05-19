
# DynaType

DynaType is a JSON validation library for Dart, providing an easy way to validate JSON structure, field names, and field types.

## Features

- JSON structure validation
- JSON field name validation
- JSON field type validation

## Getting Started

To use this package, add `dynatype` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  dynatype: ^1.0.0
```

Then, import the package to your Dart code:

```dart
import 'package:dynatype/dynatype.dart';
```

## Usage

To validate your JSON, create a new instance of `DynaValidator` and pass the JSON string and the required schema to it:

```
DynaValidator(
  json: json,
  schema: {
    "": [
      DynaType(key: "book", type: Map<String, dynamic>),
      DynaType(key: "language", type: String),
      DynaType(key: "language2", type: String),
      DynaType(key: "publish", type: int),
    ],
    "book": [
      DynaType(key: "name", type: String),
      DynaType(key: "author", type: String),
    ],
  },
).validate();
```

The schema should be a `Map<String, List<DynaType>>`. The keys of the map are the keys of the JSON object to validate, and the values are lists of `DynaType` objects which describe the required keys and their types in the corresponding JSON object. For validating the main JSON object, use an empty string as the key.

If validation fails, a `FormatException` will be thrown with details about the missing or incorrect fields.

## Example

```dart
import 'package:dynatype/dynatype.dart';

void main() {
  const String json =
      "{\"book\":{\"name\":\"200\",\"author\":\"Lingod\"},\"language\":\"english\",\"language2\":\"english\",\"publish\":1988}";

  try {
    DynaValidator(
      json: json,
      schema: {
        "": [
          DynaType(key: "book", type: Map<String, dynamic>),
          DynaType(key: "language", type: String),
          DynaType(key: "language2", type: String),
          DynaType(key: "publish", type: int),
        ],
        "book": [
          DynaType(key: "name", type: String),
          DynaType(key: "author", type: String),
        ],
      },
    ).validate();
    print("The response is correct");
  } catch (e) {
    print('Error: $e');
  }
}
```

## License

This package is licensed under the [BSD 3-Clause License](LICENSE).
