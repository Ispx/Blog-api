import 'package:blog_api/domain/models/user_model.dart';

abstract class GetUserByEmailAndPasswordRepository {
  Future<UserModel> call(String email, String password);
}
