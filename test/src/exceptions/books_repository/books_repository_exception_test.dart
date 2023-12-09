import 'package:desafio_tecnico_2/src/exceptions/books_repository/books_repository_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final requestOptions = RequestOptions();

  testWidgets(
    'deve retornar uma mensagem de erro para DioExceptionType.badResponse',
    (tester) async {
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.badResponse,
      );

      final e = BooksRepositoryDioException.exceptionMessage(exception);
      expect(e.message, equals('Nenhum dado recebido'));
    },
  );
  testWidgets(
    'deve retornar uma mensagem de erro para DioExceptionType.connectionError',
    (tester) async {
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionError,
      );

      final e = BooksRepositoryDioException.exceptionMessage(exception);
      expect(e.message, equals('Verifique se está conectado à internet'));
    },
  );

  testWidgets(
    'deve retornar uma mensagem de erro para DioExceptionType.connectTimeout',
    (tester) async {
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionTimeout,
      );

      final e = BooksRepositoryDioException.exceptionMessage(exception);
      expect(e.message, equals('Verifique se está conectado à internet'));
    },
  );

  testWidgets(
    'deve retornar uma mensagem de erro para DioExceptionType.receiveTimeout',
    (tester) async {
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.receiveTimeout,
      );

      final e = BooksRepositoryDioException.exceptionMessage(exception);
      expect(e.message, equals('Verifique se está conectado à internet'));
    },
  );

  testWidgets(
    'deve retornar uma mensagem de erro para DioExceptionType.sendTimeout',
    (tester) async {
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.sendTimeout,
      );

      final e = BooksRepositoryDioException.exceptionMessage(exception);
      expect(e.message, equals('Verifique se está conectado à internet'));
    },
  );

  testWidgets(
    'deve retornar uma mensagem de erro para DioExceptionType.sendTimeout',
    (tester) async {
      final exception = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.unknown,
      );

      final e = BooksRepositoryDioException.exceptionMessage(exception);
      expect(e.message, equals('Erro ao acessar API'));
    },
  );
}
