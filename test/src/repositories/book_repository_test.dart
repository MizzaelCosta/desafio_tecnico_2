import 'package:desafio_tecnico_2/src/repositories/api/book_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/classes.dart';
import '../mocks/constants.dart';

void main() {
  final dio = DioMock();
  final repository = BooksRepositoryDio(dio);
  final requestOptions = RequestOptions();
  test(
    'deve retornar uma lista de "books"',
    () async {
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: listOfTenBooksMaps,
              statusCode: 200,
              requestOptions: requestOptions));

      final list = await repository.get();

      expect(list.isNotEmpty, equals(true));
      expect(list[1].title, equals("Kazan"));
      expect(list.length, equals(10));
    },
  );

  test(
    'deve lançar um erro com statusCode diferente de 200',
    () async {
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: [], statusCode: 404, requestOptions: requestOptions));

      expect(() async => await repository.get(), throwsException);
    },
  );
}
