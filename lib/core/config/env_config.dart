import '../utils.dart';

class EnvConfig {
  String _file = 'lib/presenter/env.csv';
  static Map<String, dynamic> _data = {
    'HOST_SERVER': '0.0.0.0',
    'PORT_SERVER': '8080',
    'HOST_DB': 'localhost',
    'PORT_DB': '3306',
    'USER_DB': 'dart_user',
    'PASSWORD_DB': 'dart_pass',
    'JWT_KEY': 'XxJWTxX'
  };

  static EnvConfig? _i;
  EnvConfig._(String? file) {
    if (_i != null) return;
    _file = file ?? _file;
    _i = this;
  }
  factory EnvConfig(String file) => _i ?? EnvConfig._(file);
  Future<void> init() async {
    _data = await Utils.loadDataFile(_file);
  }

  static Map<String, dynamic> get getData => _data;
  factory EnvConfig.fromFile(String file) => EnvConfig._(file);
}
