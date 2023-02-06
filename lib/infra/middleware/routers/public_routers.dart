class PublicRouters {
  final _routers = <String>[];
  List<String> get routers => _routers;
  void add(String router) => _routers.add(router.replaceAll('/', ''));
}
