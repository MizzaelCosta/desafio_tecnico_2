import 'package:desafio_tecnico_2/src/exceptions/books_repository/books_repository_exception.dart';
import 'package:dio/dio.dart';

import '../../models/book.dart';

abstract class BooksRepository {
  Future<List<Book>> get();
}

class BooksRepositoryDio implements BooksRepository {
  const BooksRepositoryDio(this.dio);

  final Dio dio;

  @override
  Future<List<Book>> get() async {
    const url = 'https://escribo.com/books.json';
    final books = <Book>[];
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        for (var book in response.data!) {
          books.add(Book.fromMap(book));
        }
      } else {
        throw DioException(
            requestOptions: RequestOptions(path: url),
            response: response,
            type: DioExceptionType.badResponse);
      }
    } on DioException catch (exception) {
      throw BooksRepositoryDioException().checkException(exception);
    } catch (e) {
      throw BooksRepositoryDioException(message: 'Ocorreu um erro inesperado');
    }
    return books;
  }
}
