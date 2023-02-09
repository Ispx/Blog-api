import 'package:blog_api/core/utils.dart';
import 'package:blog_api/domain/models/user_model.dart';
import 'package:password_dart/password_dart.dart';
import 'package:test/test.dart';

final _password = Password.hash('12345', PBKDF2());
//"$pcks$64,10000,64$530f8afbc74536b9a963b4f1c4cb738bcea7403d4d606b6e074ec5d3baf39d18$5342d15b694ec2eddfb6805781d9ac434b56afbb10149b9da7ed3d8fe7419a64b289b8608f01277f418a4959385b12390bb061be323c5a6d9cfad4dfea5649c7"

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
