import 'custom_exception.dart';

class UserNotFoundException extends CustomException {
  UserNotFoundException() : super('Usuário não encontrado');
}
