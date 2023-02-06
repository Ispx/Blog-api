import 'package:blog_api/core/injection_manager/lib/injection_manager.dart';
import 'package:blog_api/infra/dao/news_model_dao.dart';
import 'package:blog_api/infra/dao/user_model_dao.dart';
import 'package:blog_api/infra/repositories/get_user_by_email_repository_imp.dart';
import 'package:blog_api/infra/services/database/mysql_database_service_imp.dart';
import 'package:blog_api/presenter/controllers/user_controller.dart';
import '../../infra/middleware/authorization_middleware_imp.dart';
import '../../infra/middleware/custom_header_middleware_imp.dart';
import '../../infra/middleware/routers/public_routers.dart';
import '../../infra/service/news_service_imp.dart';
import '../../infra/service/user_service_imp.dart';
import '../../infra/services/jwt/jwt_service_imp.dart';
import '../../presenter/controllers/news_controller.dart';
import '../../presenter/controllers/login_controller.dart';
import '../../presenter/routers/app_routers.dart';
import '../config/env_config.dart';

class DependencieInjector {
  static final i = InjectionManager();

  static init() {
    i.register<JwtServiceImp>(
      JwtServiceImp(
        EnvConfig.getData['JWT_KEY'],
      ),
    );
    i.register(
      LoginController(
        jwtService: i.get<JwtServiceImp>(),
        midlewares: [
          CustomHeaderMiddlewareImp().call(),
        ],
        getUserByEmailAndPasswordRepository:
            GetUserByEmailRepositoryImp(MysqlDataBaseServiceImp()),
      ),
    );

    i.register(
      NewsController(
        newsService: NewsServiceImp(NewsModelDao(MysqlDataBaseServiceImp())),
        jwtService: i.get<JwtServiceImp>(),
        midlewares: [
          AuthorizationMiddlewareImp(
            jwtService: JwtServiceImp(EnvConfig.getData['JWT_KEY']),
            publicRouters: PublicRouters()..add(AppRouters.login),
          ).call(),
          CustomHeaderMiddlewareImp().call(),
        ],
      ),
    );
    i.register(
      UserController(
        userService: UserServiceImp(UserModelDao(MysqlDataBaseServiceImp())),
        middlewares: [
          AuthorizationMiddlewareImp(
            jwtService: i.get<JwtServiceImp>(),
            publicRouters: PublicRouters()..add(AppRouters.login),
          ).call(),
          CustomHeaderMiddlewareImp().call(),
        ],
      ),
    );
  }
}
