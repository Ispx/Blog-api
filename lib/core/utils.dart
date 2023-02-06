import 'dart:io';

import 'package:password_dart/password_dart.dart';

class Utils {
  static Utils? _i;
  Utils._() {
    _i ??= this;
  }
  factory Utils() => _i ?? Utils._();

  static Future<Map<String, dynamic>> loadDataFile(String file,
      {String pattern = '='}) async {
    var rows = await _readRowsFile(file);
    return _parseRowsToMap(rows, pattern: pattern);
  }

  static Map<String, dynamic> _parseRowsToMap(List<String> rows,
          {String pattern = '='}) =>
      {for (var row in rows) row.split(pattern).first: row.split(pattern).last};

  static Future<List<String>> _readRowsFile(String file) async {
    return await File(file).readAsLines();
  }

  static String generateHashPassword(String password) {
    return Password.hash(password, PBKDF2());
  }
}
