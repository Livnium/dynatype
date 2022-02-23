import 'package:dynatype/dynatype.dart';

///This is My json List which i will receive in response or request.
///You can try removing fields and text it.
final json = {
  "book": {"name": "200", "author": 200} as Map,
  "language": "english",
  "language2": "english",
  "publish": 1988
};

void main() {
  ///Here i am defining the fields i required.
  final List<DynaType> _requiredMain = [
    DynaType(key: "book", type: Map<String, Object>),
    DynaType(key: "language", type: String),
    DynaType(key: "language2", type: String),
    DynaType(key: "publish", type: int),
  ];

  final List<DynaType> _requiredBook = [
    DynaType(key: "name", type: String),
    DynaType(key: "author", type: int),
  ];



  ///this is the [DynaType.verifyFields()] function which returns the missing, null and wrong data type Keys.
  DynaFields mainKeys = DynaType.verifyFields(
    data: json,
    presence: _requiredMain,
  );
  print(mainKeys.notFound.keys);

  if(mainKeys.isEmpty){
    ///Data always accepts Map you cannot pass an object inside the data as it a request.
    DynaFields bookKeys = DynaType.verifyFields(data: json["book"], presence: _requiredBook);
    print(bookKeys.notFound);
  }

  ///Here is the output
}
