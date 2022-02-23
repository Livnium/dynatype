import 'dart:convert';
import 'package:dynatype/dynacheck.dart';
import 'package:dynatype/dynatype.dart';

//This is My json List which i will receive in response or request.
//You can try removing fields and text it.
String json =
    "{\"book\":{\"name\":\"200\",\"author\":\"Lingod\"},\"language\":\"english\",\"language2\":\"english\",\"publish\":1988}";

void main() {
  //Here i am defining the fields i required.
  final List<DynaType> _requiredMain = [
    DynaType(key: "book", type: Map<String, dynamic>),
    DynaType(key: "language", type: String),
    DynaType(key: "language2", type: String),
    DynaType(key: "publish", type: int),
  ];

  final List<DynaType> _requiredBook = [
    DynaType(key: "name", type: String),
    DynaType(key: "author", type: String),
  ];

  //this is the [instance.verifyFields()] function which returns the missing, null and wrong data type Keys.
  DynaCheck main = DynaCheck(data: jsonDecode(json), presence: _requiredMain);
  if (main.verifyFields().isEmpty) {
    DynaCheck book =
        DynaCheck(data: jsonDecode(json)["book"], presence: _requiredBook);
    if (book.verifyFields().isEmpty) {
      print("The response is correct");
    } else {
      print("Missing or incorrect fields ${book.verifyFields().notFound.dyna}");
    }
  } else {
    print("Missing or incorrect fields ${main.verifyFields().notFound.dyna}");
  }
}
