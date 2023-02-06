abstract class Dao<T> {
  Future<T> create(T data);
  Future<T?> findOne<E>(E data);
  Future<List<T>> findAll();
  Future<bool> delete<E>(E data);
  Future<bool> update(T data);
}
