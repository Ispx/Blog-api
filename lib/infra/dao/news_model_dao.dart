import 'package:blog_api/infra/dao/dao.dart';
import 'package:blog_api/infra/dtos/news_model_dto.dart';
import 'package:blog_api/infra/services/database/database_service.dart';
import 'package:mysql1/mysql1.dart';
import '../../domain/models/news_model.dart';

class NewsModelDao implements Dao<NewsModel> {
  DatabaseService databaseService;
  NewsModelDao(this.databaseService);
  NewsModel _parseFromMap(Map map) {
    return NewsModelDto.fromJson(map.cast());
  }

  @override
  Future<NewsModel> create(NewsModel newsModel) async {
    final results = await databaseService.query<Results>(
        'INSERT INTO noticias(titulo,descricao,dt_criacao,id_usuario) VALUES(?,?,?,?)',
        [
          newsModel.title,
          newsModel.description,
          DateTime.now().toString(),
          newsModel.userId
        ]);
    if ((results?.affectedRows ?? 0) == 0) {
      throw Exception("Não foi possível criar a noticia");
    }
    return newsModel;
  }

  @override
  Future<bool> delete<int>(int id) async {
    final results = await databaseService
        .query<Results>('DELETE FROM noticias WHERE id = ?', [id]);
    return (results?.affectedRows ?? 0) > 0;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    final results =
        await databaseService.query<Results>('SELECT * FROM noticias');
    return results?.map((e) {
          return _parseFromMap(e.fields.cast());
        }).toList() ??
        [];
  }

  @override
  Future<NewsModel?> findOne<int>(int id) async {
    final results = await databaseService
        .query<Results>('SELECT * FROM noticias WHERE id = ?', [id]);

    return (results?.isEmpty ?? true)
        ? null
        : results?.map((e) => _parseFromMap(e.fields.cast())).first;
  }

  @override
  Future<bool> update(NewsModel newsModel) async {
    final results = await databaseService.query<Results>(
      'UPDATE noticias SET titulo = ?, descricao = ?, dt_atualizacao = ?,id_usuario = ? WHERE id = ?',
      [
        newsModel.title,
        newsModel.description,
        DateTime.now().toString(),
        newsModel.userId,
        newsModel.id,
      ],
    );
    return (results?.affectedRows ?? 0) > 0;
  }
}
