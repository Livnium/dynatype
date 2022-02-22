import 'package:dynatype/dynatype.dart';

///This is My json List which i will receive in response or request.
///You can try removing fields and text it.
Map<String, dynamic> json = {
  "book": {"name": "The alchemist", "author": "Paulo Coelho"},
  "language": "english",
  "publish": 1988
};

void main() {
  ///Here i am defining the fields i required.
  final List<DynaType> required = [
    DynaType(key: "book", type: Map<String, dynamic>),
    DynaType(key: "language", type: String),
    DynaType(key: "publish", type: int),
  ];

  ///this is the [DynaType.verifyFields()] function which returns the missing, null and wrong data type Keys.
  DynaFields mainKey = DynaType.verifyFields(
    data: json,
    presence: required,
  );

  ///Here is the output
  print(mainKey.notFound.keys);
}
