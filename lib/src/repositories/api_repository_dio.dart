import 'package:dio/dio.dart';

import '../models/book.dart';
import 'api_repository.dart';

class BooksRepositoryDio implements BooksRepository {
  const BooksRepositoryDio(this.dio);

  final Dio dio;

  @override
  Future<List<Book>> get() async {
    final response = await dio.get('https://escribo.com/books.json');

    if (response.statusCode == 200) {
      final books = <Book>[];

      for (var book in response.data) {
        books.add(Book.fromMap(book));
      }

      return books;
    } else {
      throw Exception('Erro ao carregar.');
    }
  }
}
