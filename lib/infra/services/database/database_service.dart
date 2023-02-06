abstract class DatabaseService {
  Future<void> open();
  Future<T?> query<T>(String query, [List<dynamic> args]);
  Future<void> close();
}
