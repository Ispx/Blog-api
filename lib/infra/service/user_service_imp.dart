import 'package:blog_api/core/utils.dart';
import 'package:blog_api/domain/models/user_model.dart';
import 'package:blog_api/domain/service/user_service.dart';
import 'package:blog_api/infra/dao/dao.dart';

class UserServiceImp implements UserService {
  Dao<UserModel> dao;
  UserServiceImp(this.dao);
  @override
  Future<UserModel> create(UserModel userModel) async {
    userModel = userModel.copyWith(
        password: Utils.generateHashPassword(userModel.password!));
    return await dao.create(userModel);
  }

  @override
  Future<bool> delete(int id) async {
    return await dao.delete(id);
  }

  @override
  Future<List<UserModel>> findAll() async {
    return await dao.findAll();
  }

  @override
  Future<bool> update(UserModel userModel) async {
    return await dao.update(userModel);
  }

  @override
  Future<UserModel?> findById(int id) async {
    return await dao.findOne(id);
  }
}
