import 'package:blog_api/core/config/env_config.dart';
import 'package:blog_api/core/config/server_config.dart';
import 'package:blog_api/core/extentions/string_extentios.dart';
import 'package:blog_api/core/injection_manager/dependencie_injector.dart';
import 'package:blog_api/presenter/controllers/news_controller.dart';
import 'package:blog_api/presenter/controllers/login_controller.dart';
import 'package:blog_api/presenter/controllers/user_controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

void main(List<String> args) async {
  await EnvConfig('lib/presenter/env.csv').init();
  DependencieInjector.init();
  final swaggerHandler = SwaggerUI(
    'specs/swagger.yaml',
    title: 'Swagger Blog api',
    docExpansion: DocExpansion.list,
    syntaxHighlightTheme: SyntaxHighlightTheme.nord,
  );
  final cascadeHandler = Cascade()
      .add(
        DependencieInjector.i.get<LoginController>().getHandler(),
      )
      .add(
        DependencieInjector.i.get<NewsController>().getHandler(),
      )
      .add(
        DependencieInjector.i.get<UserController>().getHandler(),
      )
      .add(swaggerHandler)
      .handler;
  await ServerConfig.run(
    host: EnvConfig.getData['HOST_SERVER'],
    port: EnvConfig.getData['PORT_SERVER'].toString().parseToType<int>(),
    handler: cascadeHandler,
  );
}
