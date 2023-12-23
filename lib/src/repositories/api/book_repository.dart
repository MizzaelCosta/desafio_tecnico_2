import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../exceptions/books_repository/books_repository_exception.dart';
import '../../models/book.dart';

abstract class BooksRepository {
  Future<List<Book>> getBooks();
  Future<Uint8List> getCoverImage(String url);
}

class BooksRepositoryDio implements BooksRepository {
  const BooksRepositoryDio(this.dio);

  final Dio dio;

  @override
  Future<List<Book>> getBooks() async {
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

  @override
  Future<Uint8List> getCoverImage(String url) async {
    try {
      var cover = Uint8List.fromList([255, 255, 255]);

      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          cover = response.data!;
        }
      } else {
        throw DioException(
            requestOptions: RequestOptions(path: url),
            response: response,
            type: DioExceptionType.badResponse);
      }
      return cover;
      //
    } on DioException catch (exception) {
      throw BooksRepositoryDioException.exceptionMessage(exception);
    }
  }
}
