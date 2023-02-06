import 'package:blog_api/domain/models/news_model.dart';

class NewsModelDto extends NewsModel {
  NewsModelDto({
    super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    super.updateAt,
    required super.userId,
  });

  factory NewsModelDto.fromJson(Map<String, dynamic> map) => NewsModelDto(
        id: map['id'],
        title: map['titulo'],
        description: map['descricao'].toString(),
        createdAt: map['dt_criacao'] != null
            ? DateTime.parse(map['dt_criacao'].toString())
            : null,
        updateAt: map['dt_atualizacao'] != null
            ? DateTime.parse(map['dt_atualizacao'].toString())
            : null,
        userId: map['id_usuario'],
      );
}
