import 'package:equatable/equatable.dart';

/// `DynaType` is a class representing a key-type pair in JSON data.
///
/// It is used in conjunction with `DynaValidator` to define a JSON schema
/// for validation.
class DynaType extends Equatable {
  /// `key` is the name of the field in the JSON data.
  final String key;

  /// `type` is the expected data type of the field in the JSON data.
  final Type type;

  /// Creates a new instance of `DynaType`.
  ///
  /// - `key`: The name of the field.
  /// - `type`: The expected data type of the field.
  DynaType({required this.key, required this.type});

  /// Overrides `props` from `Equatable` to include `key` and `type` for
  /// equality checks and for `toString` usage.
  @override
  List<Object> get props => [key, type];
}
