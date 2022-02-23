library dynatype;

import 'package:dynatype/dynacheck.dart';
import 'package:equatable/equatable.dart';
export 'src/dynatype_base.dart';

///[DynaFields] is a class which contains list<[DynaType]> of notFound or null or incorrect fields in [notFound] list
///It also contains [isEmpty]
///if every thing in the json response was correct then it will provide isEmpty true by using this you can make condition
///statements.
class DynaFields {
  ///[notFound] is [List<DynaType>] which is outputted by [DynaCheck] instance.
  final List<DynaType> notFound;

  ///[isEmpty] is bool which store true if the list notFound is Empty
  ///false if it contains some incorrect dynatypes you received from json.
  late bool isEmpty;

  DynaFields({required this.notFound}) {
    isEmpty = notFound.isEmpty;
  }
}

///[DynaType] is the core class which contains keys and there data types of
///presence or jsonResponse.
class DynaType extends Equatable {
  ///[Key] should match to the key that you require in json.
  final String key;

  ///[Type] should be the DataType that you want the value of the Map to be.
  final Type type;

  ///This is the constructor of DynaType class.
  DynaType({required this.key, required this.type});

  ///[noDynaType] just returns the key of that DynaType
  static String noDynaType(DynaType data) {
    return data.key.toString();
  }

  @override
  List<Object> get props => [key, type];
}

///[DynaTypeExtension] is the extension of List<DynaType>
extension DynaTypeExtension on List<DynaType> {
  ///This [dyna] extension helps to get all the missing keys from the json response it needs [List<DynaType>].
  List<String> get dyna => map((e) => DynaType.noDynaType(e)).toSet().toList();
}
