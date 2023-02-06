import 'package:shelf/shelf.dart';

abstract class ApiController {
  Handler getHandler();
  Handler createHandler(
    Handler router, {
    List<Middleware>? midlewares,
  }) {
    var pepiline = Pipeline();
    midlewares ??= [];
    midlewares
        .forEach(((element) => pepiline = pepiline.addMiddleware((element))));
    return pepiline.addHandler(router);
  }
}
