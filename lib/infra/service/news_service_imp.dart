import 'package:blog_api/domain/models/news_model.dart';
import 'package:blog_api/domain/service/news_service.dart';
import 'package:blog_api/infra/dao/dao.dart';

class NewsServiceImp implements NewService {
  Dao<NewsModel> dao;
  NewsServiceImp(this.dao);
  @override
  Future<NewsModel> create(NewsModel newsModel) async {
    return await dao.create(newsModel);
  }

  @override
  Future<bool> delete(int id) async {
    return await dao.delete(id);
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return await dao.findAll();
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    return await dao.findOne(id);
  }

  @override
  Future<bool> update(NewsModel newsModel) async {
    return await dao.update(newsModel);
  }
}
