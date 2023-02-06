import 'package:blog_api/domain/models/user_model.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class JwtService {
  Future<String> generateToken(UserModel userModel);
  Future<bool> validateToken(String token);
  JwtClaim? getJwt(String token);
}
