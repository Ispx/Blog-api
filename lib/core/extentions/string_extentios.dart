extension StringExt on String {
  T parseToType<T>() {
    switch (T) {
      case int:
        return int.parse(this) as T;
      default:
        return this as T;
    }
  }
}
