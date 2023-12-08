abstract class ExceptionHandled implements Exception {
  ExceptionHandled(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
