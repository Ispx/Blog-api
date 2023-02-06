import 'dart:convert';

import 'package:blog_api/domain/service/user_service.dart';
import 'package:blog_api/infra/dtos/user_dto.dart';
import 'package:blog_api/presenter/routers/app_routers.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'api_controller.dart';

class UserController extends ApiController {
  final UserService userService;
  final List<Middleware> middlewares;
  UserController({
    required this.userService,
    required this.middlewares,
  });
  @override
  Handler getHandler() {
    final router = Router();
    _create(router);
    _update(router);
    return createHandler(router, midlewares: middlewares);
  }

  void _create(Router router) {
    router.post(AppRouters.user, (Request req) async {
      try {
        final data = await req.readAsString();
        final body = jsonDecode(data);
        final userModel = UserModelDto.fromMap(body);
        final userModelCreated = await userService.create(userModel);
        return Response(201, body: jsonEncode(userModelCreated.toJson()));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
    });
  }

  void _update(Router router) {
    router.post(AppRouters.user, (Request req) async {
      try {
        final data = await req.readAsString();
        final body = jsonDecode(data);
        final userModel = UserModelDto.fromMap(body);
        final userModelCreated = await userService.create(userModel);
        return Response.ok(jsonEncode(userModelCreated.toJson()));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
    });
  }
}
