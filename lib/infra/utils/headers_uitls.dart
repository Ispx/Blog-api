class HeadersUtils {
  static HeadersUtils? _i;
  HeadersUtils._() {
    _i ??= this;
  }
  factory HeadersUtils() => _i ?? HeadersUtils._();
  static var applicationJson = {"content-type": "application/json"};
  static var accessAllows = {"Access-Control-Allow-Origin": "*"};
  static var methodsAllows = {"Access-Control-Allow-Methods": "GET,POST,PUT"};
}
