import 'dart:convert';
import 'package:blog_api/core/extentions/string_extentios.dart';
import 'package:blog_api/infra/dtos/news_model_dto.dart';
import 'package:blog_api/infra/services/jwt/jwt_service.dart';
import 'package:blog_api/presenter/controllers/api_controller.dart';
import 'package:blog_api/presenter/routers/app_routers.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../domain/service/news_service.dart';

class NewsController extends ApiController {
  final NewService newsService;
  final JwtService jwtService;
  final List<Middleware>? midlewares;

  NewsController({
    required this.newsService,
    this.midlewares,
    required this.jwtService,
  });
  @override
  Handler getHandler() {
    final router = Router();
    _create(router);
    _getAll(router);
    _findOne(router);
    _update(router);
    _delete(router);
    return createHandler(router, midlewares: midlewares);
  }

  void _create(Router router) {
    router.post(
      AppRouters.news,
      (Request request) async {
        try {
          var data = await request.readAsString();
          var body = jsonDecode(data);
          JwtClaim claims =
              jwtService.getJwt(request.headers['Authorization']!)!;
          int userId = claims.payload['id_usuario'];
          body['id_usuario'] = userId;
          final newsCreated =
              await newsService.create(NewsModelDto.fromJson(body));
          return Response(201, body: jsonEncode(newsCreated.toJson()));
        } catch (e) {
          return Response.badRequest(body: "Ocorreu um erro: ${e.toString()}");
        }
      },
    );
  }

  void _getAll(Router router) {
    router.get(AppRouters.findAllNews, (Request req) async {
      final news = await newsService.findAll();
      final json = jsonEncode(news.map((e) => e.toJson()).toList());
      return Response.ok(json);
    });
  }

  void _findOne(Router router) {
    router.get(AppRouters.news, (Request req) async {
      int? id = req.url.queryParameters['id']?.parseToType<int>();
      if (id == null) {
        return Response.badRequest(
          body: jsonEncode(
            "Id da noticia deve ser informado",
          ),
        );
      }
      final newsModel = await newsService.findOne(id);
      if (newsModel == null) {
        return Response.ok(jsonEncode({"error_message": "id não encontrado"}));
      }
      return Response.ok(jsonEncode(newsModel.toJson()));
    });
  }

  void _update(Router router) {
    router.put(
      AppRouters.news,
      (Request req) async {
        try {
          int? id = req.url.queryParameters['id']?.parseToType<int>();
          if (id == null) {
            return Response.badRequest(
                body: jsonEncode("id não pode ser nulo."));
          }
          final data = await req.readAsString();
          final body = jsonDecode(data);
          body['id'] = id;
          body['id_usuario'] = jwtService
              .getJwt(req.headers['Authorization']!)!
              .payload['id_usuario'];
          final isUpdated =
              await newsService.update(NewsModelDto.fromJson(body));
          return Response.ok(isUpdated);
        } catch (e) {
          return Response.internalServerError(body: e.toString());
        }
      },
    );
  }

  void _delete(Router router) {
    router.delete(AppRouters.news, (Request req) async {
      int? id = req.url.queryParameters['id']?.parseToType<int>();
      if (id == null) {
        return Response.badRequest(
          body: jsonEncode(
            "Id da noticia deve ser informado",
          ),
        );
      }
      final isDeleted = await newsService.delete(id);
      return Response.ok(isDeleted);
    });
  }
}
