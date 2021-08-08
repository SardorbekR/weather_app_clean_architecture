import 'dart:io';

String readFromJson(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();
