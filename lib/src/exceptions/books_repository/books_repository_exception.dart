// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../exception_handles.dart';

class BooksRepositoryException extends ExceptionHandled {
  BooksRepositoryException(super.message);
}

class BooksRepositoryDioException extends BooksRepositoryException {
  BooksRepositoryDioException(super.message);

  factory BooksRepositoryDioException.exceptionMessage(DioException exception) {
    final message = _returnsMessageByExceptionType(exception);

    return BooksRepositoryDioException(message);
  }

  static String _returnsMessageByExceptionType(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return 'Nenhum dado recebido';

      case DioExceptionType.connectionError:
        return 'Verifique se está conectado à internet';

      case DioExceptionType.connectionTimeout:
        return 'Verifique se está conectado à internet';

      case DioExceptionType.receiveTimeout:
        return 'Verifique se está conectado à internet';

      case DioExceptionType.sendTimeout:
        return 'Verifique se está conectado à internet';

      default:
        return 'Erro ao acessar API';
    }
  }
}
