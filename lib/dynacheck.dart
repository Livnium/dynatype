import 'package:dynatype/dynatype.dart';


///[DynaCheck] is the class which holds the jsonResponse and
///presence of the json response how you want that jsonResponse to look like.
class DynaCheck {

  ///Pass [Map<String,dynamic>] json in the data.
  final Map<String, dynamic> data;

  ///Pass [List<DynaType>] List in presence.
  final List<DynaType> presence;


  ///This is the constructor of DynaCheck class
  DynaCheck({
    required this.data,
    required this.presence,
  });

  ///This Method get you the Missing data and there data types.
  DynaFields verifyFields() {
    List<DynaType> gotData = data.entries.map((e) {
      return _dynaTypeCheck(e);
    }).toList();
    List<DynaType> difference =
        presence.toSet().difference(gotData.toSet()).toList();
    var nullEntries = data.entries.where((e) => e.value == null).toList();
    List<DynaType> nullKeys = nullEntries.map((e) {
      return _dynaTypeCheck(e);
    }).toList();
    List<DynaType> required = difference + nullKeys;
    return DynaFields(notFound: required);
  }

  ///this is a private function it helps tho differentiate bet Map DataTypes
  DynaType _dynaTypeCheck(e) {
    // print(e.value.runtimeType);
    if (e.value.runtimeType.toString().replaceAll(" ", "") ==
        "_InternalLinkedHashMap<String, dynamic>".replaceAll(" ", "")) {
      return DynaType(key: e.key, type: Map<String, dynamic>);
    } else if (e.value.runtimeType.toString().replaceAll(" ", "") ==
        "_InternalLinkedHashMap<String, String>".replaceAll(" ", "")) {
      return DynaType(key: e.key, type: Map<String, String>);
    } else if (e.value.runtimeType.toString().replaceAll(" ", "") ==
        "_InternalLinkedHashMap<String, int>".replaceAll(" ", "")) {
      return DynaType(key: e.key, type: Map<String, int>);
    } else if (e.value.runtimeType.toString().replaceAll(" ", "") ==
        "_InternalLinkedHashMap<String, Object>".replaceAll(" ", "")) {
      return DynaType(key: e.key, type: Map<String, Object>);
    }
    return DynaType(key: e.key, type: e.value.runtimeType);
  }
}
