import 'package:blog_api/domain/models/user_model.dart';

class UserModelDto extends UserModel {
  UserModelDto({
    required super.id,
    required super.name,
    required super.email,
    required super.isActive,
    required super.password,
    super.createdAt,
    super.updateAt,
  });

  factory UserModelDto.fromMap(Map<String, dynamic> map) {
    return UserModelDto(
      id: map['id'],
      name: map['nome'],
      email: map['email'],
      isActive: map['is_ativo'] == 1,
      password: map['password'],
      createdAt: map['dt_criacao'] != null
          ? DateTime.parse(map['dt_criacao'].toString())
          : null,
      updateAt: map['dt_atualizacao'] != null
          ? DateTime.parse(map['dt_atualizacao'].toString())
          : null,
    );
  }
}
