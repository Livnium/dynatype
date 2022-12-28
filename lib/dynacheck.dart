import 'package:dynatype/dynatype.dart';

class DynaCheck {
  final Map<String, dynamic> data;
  final List<DynaType> presence;

  DynaCheck({
    required this.data,
    required this.presence,
  });

  DynaFields verifyFields() {
    List<DynaType> gotData = data.entries
        .map((e) => DynaType(key: e.key, type: e.value.runtimeType))
        .toList();
    List<DynaType> required = presence.toSet().difference(gotData.toSet()).toList();
    return DynaFields(notFound: required);
  }
}
