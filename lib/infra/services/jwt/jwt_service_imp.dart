import 'package:blog_api/domain/models/user_model.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import 'jwt_service.dart';

class JwtServiceImp implements JwtService {
  final String _key;
  JwtServiceImp(this._key);
  @override
  Future<String> generateToken(UserModel userModel) async {
    final claims = JwtClaim(
        subject: 'kleak',
        issuer: 'blogApi',
        expiry: DateTime.now().add(Duration(hours: 1)),
        otherClaims: <String, dynamic>{
          'typ': 'authnresponse',
          'pld': {'k': 'v'}
        },
        payload: {
          'id_usuario': userModel.id,
          'name': userModel.name,
        },
        maxAge: const Duration(minutes: 5));

    return issueJwtHS256(claims, _key);
  }

  @override
  Future<bool> validateToken(String token) async {
    try {
      final clamins = verifyJwtHS256Signature(token, _key);
      return clamins.expiry == null
          ? false
          : clamins.expiry!.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  @override
  JwtClaim? getJwt(String token) {
    try {
      return verifyJwtHS256Signature(token, _key);
    } catch (e) {
      return null;
    }
  }
}
