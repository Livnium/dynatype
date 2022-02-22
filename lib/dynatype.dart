/// Support for doing something awesome.
///
/// More dartdocs go here.
library dynatype;

import 'package:equatable/equatable.dart';

export 'src/dynatype_base.dart';

// TODO: Export any libraries intended for clients of this package.

class DynaFields {
  final List<DynaType> notFound;
  late bool isEmpty;

  DynaFields({required this.notFound}) {
    isEmpty = notFound.isEmpty;
  }
}

class DynaType extends Equatable {
  final String key;
  final Type type;

  DynaType({required this.key, required this.type});

  static String noDynaType(DynaType data) {
    return data.key.toString();
  }

  static DynaFields verifyFields({
    required Map<String, dynamic> data,
    required List<DynaType> presence,
  }) {
    // data.entries.map((e) => print(e.value == null));

    List<DynaType> gotData = data.entries.map((e) {
      if (e.value.runtimeType.toString() ==
          "_InternalLinkedHashMap<String, dynamic>") {
        return DynaType(key: e.key, type: Map<String, dynamic>);
      }
      return DynaType(key: e.key, type: e.value.runtimeType);
    }).toList();

    List<DynaType> difference =
    presence.toSet().difference(gotData.toSet()).toList();
    var nullEntries = data.entries.where((e) => e.value == null).toList();
    List<DynaType> nullKeys = nullEntries.map((e) {
      if (e.value.runtimeType.toString() ==
          "_InternalLinkedHashMap<String, dynamic>") {
        return DynaType(key: e.key, type: Map<String, dynamic>);
      } else {
        return DynaType(key: e.key, type: e.value.runtimeType);
      }
    }).toList();

    List<DynaType> required = difference + nullKeys;
    return DynaFields(notFound: required);
  }

  @override
  List<Object> get props => [key, type];
}

extension DynaTypeExtension on List<DynaType> {
  List<String> get keys => map((e) => DynaType.noDynaType(e)).toSet().toList();
}
