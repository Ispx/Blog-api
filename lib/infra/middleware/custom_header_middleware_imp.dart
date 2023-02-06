import 'package:blog_api/infra/middleware/generate_middleware.dart';
import 'package:blog_api/infra/utils/headers_uitls.dart';
import 'package:shelf/shelf.dart';

class CustomHeaderMiddlewareImp implements GenerateMiddleware {
  @override
  Middleware call() {
    return createMiddleware(
      responseHandler: (resp) => resp.change(headers: {
        ...HeadersUtils.applicationJson,
        ...HeadersUtils.accessAllows,
      }),
      requestHandler: (req) {
        if (req.method == 'OPTIONS') {
          return Response(200, headers: {
            ...HeadersUtils.applicationJson,
            ...HeadersUtils.accessAllows,
            ...HeadersUtils.methodsAllows,
          });
        }
        return null;
      },
    );
  }
}
