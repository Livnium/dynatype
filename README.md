# DynaType

[![pub package](https://img.shields.io/pub/v/dynatype.svg)](https://pub.dev/packages/dynatype) ![Build status](https://img.shields.io/github/checks-status/chetanxpatil/dynatype/main) [![style: effective dart](https://img.shields.io/badge/style-effective%20dart-brightgreen)](https://github.com/tenhobi/effective_dart)

DynaType is a flutter plugin that provides robust control on JSON Response and Request. This plugin gives you the name of the key and its value data type, which were incorrectly parsed before executing any logic, so that you can show an error in response to the request.

## Features

* Get the Missing Fields;
* Get the Missing Fields Data Type;
* Check the request is perfect;
* Declare your own request key and types;

> **IMPORTANT:**
>
> Dyna Types is still in its development phase. It is created to support the backend and middleware server created using Dart.
> DynaType will help developers check their requests and validate them before executing any functions.
>

## Usage

To add DynaType to your project, you need to import dynatype package to your project dependency.

* You need to define an instance of DynaCheck where you will pass the response of JSON and create a list using DynaType, which will determine how your JSON Response should look.
* Use the instance you got and run the verifyfields() function.
* verifyfields() function will provide you DynaFields, which contains bool isEmpty and a list of List<DynaType> notfound (notfound is a variable). where notfound contains invalid fields keys and the correct data type, which should be provided in the JSON response.
* isEmpty provides TRUE if the JSON Response was correct or provides FALSE.
* If isEmpty is false. You can get invalid MapEntries keys and datatypes from using .notfound on verifyfields Function.


### Example

The code below shows how to use DynaType and acquire all the invalid parsed values and their data types.

```dart
import 'dart:convert';
import 'package:dynatype/dynacheck.dart';
import 'package:dynatype/dynatype.dart';

//This is My json List which i will receive in response or request.
//You can try removing fields and text it.
final json = {
  "book": '{"name": "200","author":"Lin god"}',
  "language": "english",
  "language2": "english",
  "publish": 1988
};

void main() {
  //Here i am defining the fields i required.
  final List<DynaType> _requiredMain = [
    DynaType(key: "book", type: String),
    DynaType(key: "language", type: String),
    DynaType(key: "language2", type: String),
    DynaType(key: "publish", type: int),
  ];

  final List<DynaType> _requiredBook = [
    DynaType(key: "name", type: String),
    DynaType(key: "author", type: String),
  ];

  //this is the [instance.verifyFields()] function which returns the missing, null and wrong data type Keys.
  DynaCheck main = DynaCheck(data: json, presence: _requiredMain);

  if (main.verifyFields().isEmpty) {
    //Data always accepts Map you cannot pass an object inside the data as it a request.
    DynaCheck book = DynaCheck(
        data: jsonDecode(json["book"].toString()), presence: _requiredBook);
    if (book.verifyFields().isEmpty) {
      print("The response is correct");
    } else {
      print("Missing or incorrect fields ${book.verifyFields().notFound.dyna}");
    }
  }
}
```