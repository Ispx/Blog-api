class CustomException implements Exception {
  String _msg;

  CustomException(this._msg);

  @override
  String toString() {
    return _msg;
  }
}
