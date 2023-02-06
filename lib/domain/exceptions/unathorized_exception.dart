import 'package:blog_api/domain/exceptions/custom_exception.dart';

class UnAuthoriedxception extends CustomException {
  UnAuthoriedxception() : super('Token inválido ou não autenticado');
}
