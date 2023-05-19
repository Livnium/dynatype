import 'dart:convert';

import 'package:dynatype/dynatype.dart';

/// `DynaValidator` is a class used to validate JSON data based on a specified schema.
class DynaValidator {
  final String json;
  final Map<String, List<DynaType>> schema;

  /// Creates a new instance of `DynaValidator`.
  ///
  /// - `json`: The JSON string to validate.
  /// - `schema`: The schema that describes the required structure of the JSON.
  DynaValidator({required this.json, required this.schema});

  /// Verifies the presence and types of fields in the given data.
  ///
  /// If some fields are missing or their types don't match the schema, a `FormatException` is thrown.
  void _verifyFields(Map<String, dynamic> data, List<DynaType> presence) {
    List<DynaType> gotData = data.entries
        .map((e) => DynaType(key: e.key, type: e.value.runtimeType))
        .toList();
    List<DynaType> required =
        presence.toSet().difference(gotData.toSet()).toList();

    if (required.isNotEmpty) {
      throw FormatException(
          "Missing or incorrect fields: ${required.map((e) => e.key).toList()}");
    }
  }

  /// Validates the JSON data against the provided schema.
  ///
  /// If the JSON data doesn't match the schema, a `FormatException` is thrown.
  /// If the JSON string is not valid, a `FormatException` is also thrown.
  /// If the JSON data matches the schema, "The response is correct" is printed to the console.
  void validate() {
    Map<String, dynamic> decodedJson;

    try {
      decodedJson = jsonDecode(json);
    } catch (e) {
      throw FormatException('Invalid JSON: $e');
    }

    schema.forEach((key, value) {
      Map<String, dynamic> dataToValidate =
          key == "" ? decodedJson : decodedJson[key];
      _verifyFields(dataToValidate, value);
    });

    print("The response is correct");
  }
}
