import 'package:blog_api/core/config/env_config.dart';
import 'package:blog_api/core/extentions/string_extentios.dart';
import 'package:mysql1/mysql1.dart';

import 'database_service.dart';

class MysqlDataBaseServiceImp implements DatabaseService {
  MySqlConnection? _connection;

  @override
  Future<void> close() async {
    await _connection?.close();
  }

  @override
  Future<Results> query<Results>(String query, [List<dynamic>? args]) async {
    try {
      await open();
      return await _connection!.query(query, args) as Results;
    } catch (e) {
      throw Exception('[ERROR SQL] -> ${e.toString()}');
    } finally {
      await close();
    }
  }

  @override
  Future<void> open() async {
    try {
      _connection = await MySqlConnection.connect(ConnectionSettings(
          host: EnvConfig.getData['HOST_DB'],
          port: EnvConfig.getData['PORT_DB'].toString().parseToType<int>(),
          user: EnvConfig.getData['USER_DB'],
          password: EnvConfig.getData['PASSWORD_DB'],
          db: 'dart'));
    } catch (e) {
      throw Exception('[ERROR DB] -> ${e.toString()}');
    }
  }
}
