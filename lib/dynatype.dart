import 'package:equatable/equatable.dart';

class DynaFields {
  final List<DynaType> notFound;
  final bool isEmpty;

  DynaFields({required this.notFound}) : isEmpty = notFound.isEmpty;
}

class DynaType extends Equatable {
  final String key;
  final Type type;

  DynaType({required this.key, required this.type});

  static String noDynaType(DynaType data) => data.key.toString();

  @override
  List<Object> get props => [key, type];
}

extension DynaTypeExtension on List<DynaType> {
  List<String> get dyna => map((e) => DynaType.noDynaType(e)).toSet().toList();
}
