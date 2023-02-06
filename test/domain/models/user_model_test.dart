import 'package:blog_api/core/utils.dart';
import 'package:blog_api/domain/models/user_model.dart';
import 'package:password_dart/password_dart.dart';
import 'package:test/test.dart';

final _password = Password.hash('12345', PBKDF2());
main() {
  final userModel = UserModel(
    id: 1,
    name: 'Fulano',
    email: 'fulano@gmail.con',
    isActive: true,
    password: _password,
  );

  test('Verify password shoudl return true', () {
    expect(userModel.verifyPassword(Utils.generateHashPassword('12345')), true);
  });
  test('Verify password shoudl return false', () {
    expect(
        userModel.verifyPassword(Utils.generateHashPassword('123451')), false);
  });
}
