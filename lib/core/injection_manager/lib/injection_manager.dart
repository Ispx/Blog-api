typedef T Bind<T>();

class InjectionManager implements _InjectionManager {
  static InjectionManager? _i;
  InjectionManager._() {
    _i ??= this;
  }
  factory InjectionManager() => _i ?? InjectionManager._();

  final _data = <Type, _IntanceGenerator>{};

  @override
  T get<T>() {
    _IntanceGenerator? instance = _data[T];
    if (instance == null) {
      throw 'Object not registred';
    }
    return instance.get() as T;
  }

  @override
  void register<T extends Object>(T object, {bool isSingleton = false}) {
    _data[T] = _IntanceGenerator<T>(() => object, isSingleton: isSingleton);
  }
}

class _IntanceGenerator<T extends Object> {
  final Bind bind;
  T? instance;
  final bool isSingleton;
  _IntanceGenerator(
    this.bind, {
    this.isSingleton = false,
  });
  T get() {
    if (isSingleton) {
      instance ??= bind();
      return instance!;
    }
    return bind();
  }
}

abstract class _InjectionManager {
  void register<T extends Object>(T object, {bool isSingleton = false});
  T get<T>();
}
