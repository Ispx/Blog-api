import 'package:blog_api/domain/models/user_model.dart';
import 'package:blog_api/infra/dao/dao.dart';
import 'package:blog_api/infra/dtos/user_dto.dart';
import 'package:blog_api/infra/services/database/database_service.dart';
import 'package:mysql1/mysql1.dart';

class UserModelDao implements Dao<UserModel> {
  DatabaseService databaseService;
  UserModelDao(this.databaseService);
  UserModel _parseFromMap(Map map) => UserModelDto.fromMap(map.cast());
  @override
  Future<UserModel> create(UserModel userModel) async {
    final results = await databaseService.query<Results>(
        'INSERT INTO usuarios(nome,email,password,is_ativo,dt_criacao) VALUES (?,?,?,?,?)',
        [
          userModel.name,
          userModel.email,
          userModel.password,
          true,
          DateTime.now().toString(),
        ]);
    if ((results?.affectedRows ?? 0) == 0) {
      throw Exception("Não foi possível criar o usuário");
    }
    return userModel;
  }

  @override
  Future<bool> delete<int>(id) async {
    final results =
        await databaseService.query<Results>('DELETE usuarios WHERE id = ?', [
      id,
    ]);
    return (results?.affectedRows ?? 0) > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final results = await databaseService.query('SELECT * FROM usuarios');
    return results.map((e) => _parseFromMap(e.asMap())).toList();
  }

  @override
  Future<UserModel> findOne<int>(int id) async {
    final results = await databaseService
        .query('SELECT * FROM usuariosm WHERE id = ?', [id]);
    return results.map((e) => _parseFromMap(e.asMap())).first;
  }

  @override
  Future<bool> update(UserModel userModel) async {
    final results = await databaseService.query<Results>(
      'UPDATE usuarios SET nome = ?, email = ?, password = ?,isAtivo = ?, dt_atualizacao = ?',
      [
        userModel.name,
        userModel.email,
        userModel.password,
        userModel.isActive,
        DateTime.now().toString(),
      ],
    );
    return (results?.affectedRows ?? 0) > 0;
  }
}
