import 'package:desafio_tecnico_2/src/models/book.dart';
import 'package:desafio_tecnico_2/src/pages/home/home_controller.dart';
import 'package:desafio_tecnico_2/src/repositories/api/book_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/classes.dart';
import '../../mocks/constants.dart';

void main() {
  final dio = DioMock();
  final repository = BooksRepositoryDio(dio);
  final storage = LocalStorageMock();
  final controller = HomeController(repository, storage);
  final requestOptions = RequestOptions();

  test(
    'deve receber uma lista com 10 "books".',
    () async {
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: listOfTenBooksMaps,
              statusCode: 200,
              requestOptions: requestOptions));

      await controller.init();

      final books = controller.books;
      expect(books.value.length, equals(10));
    },
  );

  test(
    'deve receber uma mensagem de erro',
    () async {
      final book = Book.empty();
      when(() => storage.getAll()).thenAnswer((_) async => <Book>[]);
      when(() => storage.get(book)).thenAnswer((_) async => Book.empty());
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
        (_) async => Response(
            data: listOfTenBooksMaps,
            statusCode: 404,
            requestOptions: requestOptions),
      );

      await controller.init();

      final error = controller.error;
      expect(error.value, isNotEmpty);
      //TODO: verificar para as 3 requisições
    },
  );

  test(
    'deve modificar "isLoading" para "true" ao iniciar a requisição',
    () async {
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: listOfTenBooksMaps,
              statusCode: 200,
              requestOptions: requestOptions));

      final before = controller.isLoading.value;
      controller.init();
      final after = controller.isLoading.value;

      expect(before, isFalse);
      expect(after, isTrue);
    },
  );
}
