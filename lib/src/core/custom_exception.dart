class CustomException extends Error {
  final String message;
  CustomException(this.message);

  @override
  String toString() => message;
}
