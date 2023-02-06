import 'package:blog_api/core/utils.dart';
import 'package:blog_api/domain/exceptions/invalid_password_exception.dart';
import 'package:blog_api/domain/exceptions/user_not_found_exception.dart';
import 'package:blog_api/domain/models/user_model.dart';
import 'package:blog_api/domain/repositories/get_user_by_email_and_password_repository.dart';
import 'package:blog_api/infra/dtos/user_dto.dart';
import 'package:blog_api/infra/services/database/database_service.dart';
import 'package:mysql1/mysql1.dart';

class GetUserByEmailRepositoryImp
    implements GetUserByEmailAndPasswordRepository {
  DatabaseService databaseService;
  GetUserByEmailRepositoryImp(this.databaseService);
  @override
  Future<UserModel> call(String email, String password) async {
    try {
      final results = await databaseService.query<Results>(
        'SELECT * FROM usuarios WHERE email = ?',
        [email],
      );
      if (results?.isEmpty ?? true) {
        throw UserNotFoundException();
      }
      final userModel =
          results!.map((e) => UserModelDto.fromMap(e.fields)).first;
      if (!userModel.verifyPassword(Utils.generateHashPassword(password))) {
        throw InvalidPasswordException();
      }
      return userModel;
    } catch (e) {
      throw e.toString();
    }
  }
}
