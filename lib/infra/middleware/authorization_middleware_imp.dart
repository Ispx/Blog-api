import 'package:blog_api/infra/middleware/generate_middleware.dart';
import 'package:blog_api/infra/middleware/routers/public_routers.dart';
import 'package:blog_api/infra/services/jwt/jwt_service.dart';
import 'package:shelf/shelf.dart';

import '../../domain/exceptions/unathorized_exception.dart';

class AuthorizationMiddlewareImp extends GenerateMiddleware {
  PublicRouters publicRouters;
  JwtService jwtService;
  AuthorizationMiddlewareImp(
      {required this.jwtService, required this.publicRouters});
  @override
  Middleware call() {
    return createMiddleware(
      requestHandler: (req) async {
        if (publicRouters.routers.contains(req.url.path)) return null;
        final token = req.headers['authorization'];
        if (token == null || !await jwtService.validateToken(token)) {
          return Response.unauthorized(UnAuthoriedxception().toString());
        } else if (req.context['jwt'] == null) {
          req =
              req.change(context: {'jwt': jwtService.getJwt(token)?.toJson()});
        }
        return null;
      },
    );
  }
}
