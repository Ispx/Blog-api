import 'package:blog_api/domain/models/news_model.dart';

abstract class NewService {
  Future<NewsModel> create(NewsModel newsModel);
  Future<NewsModel?> findOne(int id);
  Future<List<NewsModel>> findAll();
  Future<bool> delete(int id);
  Future<bool> update(NewsModel newsModel);
}
