extension ListExtention<E> on List {
  E? firstWhereOrNull(bool predicate(E element)) {
    for (E element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }
}
