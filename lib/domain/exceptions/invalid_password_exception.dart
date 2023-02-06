import 'custom_exception.dart';

class InvalidPasswordException extends CustomException {
  InvalidPasswordException() : super('Senha inválida');
}
