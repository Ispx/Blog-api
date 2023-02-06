import 'package:blog_api/domain/models/user_model.dart';
import 'package:blog_api/infra/services/jwt/jwt_service_imp.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

class JwtServiceMockImp extends JwtServiceImp {
  JwtServiceMockImp(super.key);
}

void main() {
  final jwtServiceMock = JwtServiceMockImp('key');
  String token = '';

  test('should return a string', () async {
    token = await jwtServiceMock.generateToken(UserModel(
        id: 1,
        name: 'Fulano',
        email: 'fulano@gmail.com',
        isActive: true,
        password: '12345'));
    expect(token, isA<String>());
  });

  test('should return true', () async {
    expect(await jwtServiceMock.validateToken(token), true);
  });
  test('should return false', () async {
    expect(await jwtServiceMock.validateToken(''), false);
  });
}
