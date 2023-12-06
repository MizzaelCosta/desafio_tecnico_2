// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class BooksRepositoryException implements Exception {
  BooksRepositoryException({this.message});

  final String? message;
}

class BooksRepositoryDioException extends BooksRepositoryException {
  BooksRepositoryDioException({super.message});

  String checkException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return 'Não foi possível conectar';

      case DioExceptionType.connectionError:
        return 'Erro na conexão. Verifique se está conectado à internet';

      case DioExceptionType.connectionTimeout:
        return 'Demorou para conectar. Verifique se está conectado à internet';

      case DioExceptionType.receiveTimeout:
        return 'Demorou para responder. Verifique se está conectado à internet';

      default:
        return 'Ocorreu um erro';
    }
  }
}
