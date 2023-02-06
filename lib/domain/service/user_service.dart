import 'package:blog_api/domain/models/user_model.dart';

abstract class UserService {
  Future<UserModel> create(UserModel userModel);
  Future<UserModel?> findById(int id);
  Future<List<UserModel>> findAll();
  Future<bool> delete(int id);
  Future<bool> update(UserModel userModel);
}
