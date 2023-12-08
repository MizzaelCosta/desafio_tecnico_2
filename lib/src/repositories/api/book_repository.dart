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
    try {
      var books = <Book>[];
      const url = 'https://escribo.com/books.json';

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        if (response.data != null) {
          books = (response.data! as List)
              .map<Book>((map) => Book.fromMap(map))
              .toList();
        }
      } else {
        throw DioException(
            requestOptions: RequestOptions(path: url),
            response: response,
            type: DioExceptionType.badResponse);
      }
      return books;
    } on DioException catch (exception) {
      throw BooksRepositoryDioException.exceptionMessage(exception);
    }
  }
}
