import 'dart:convert';

import 'package:blog_api/domain/exceptions/invalid_password_exception.dart';
import 'package:blog_api/domain/exceptions/user_not_found_exception.dart';
import 'package:blog_api/domain/repositories/get_user_by_email_and_password_repository.dart';
import 'package:blog_api/infra/services/jwt/jwt_service.dart';
import 'package:blog_api/presenter/routers/app_routers.dart';
import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import 'api_controller.dart';

class LoginController extends ApiController {
  final JwtService jwtService;
  final List<Middleware>? midlewares;
  final GetUserByEmailAndPasswordRepository getUserByEmailAndPasswordRepository;
  LoginController({
    required this.jwtService,
    required this.getUserByEmailAndPasswordRepository,
    this.midlewares,
  });

  @override
  Handler getHandler() {
    final router = Router();
    _authenticate(router);
    return createHandler(router, midlewares: midlewares);
  }

  void _authenticate(Router router) {
    router.post(
      AppRouters.login,
      (Request req) async {
        try {
          final data = await req.readAsString();
          final json = jsonDecode(data);
          final email = json['email'];
          final password = json['password'];
          final userModel =
              await getUserByEmailAndPasswordRepository(email, password);
          final token = await jwtService.generateToken(userModel);
          final body = jsonEncode({
            'token': token,
            'user_id': userModel.id,
          });
          return Response(200, body: body);
        } on UserNotFoundException catch (e) {
          return Response.badRequest(
              body: jsonEncode({
            'message_error': e.toString(),
          }));
        } on InvalidPasswordException catch (e) {
          return Response.badRequest(
              body: jsonEncode({
            'message_error': e.toString(),
          }));
        } catch (e) {
          return Response.badRequest(
              body: jsonEncode({
            'message_error': e.toString(),
          }));
        }
      },
    );
  }
}
