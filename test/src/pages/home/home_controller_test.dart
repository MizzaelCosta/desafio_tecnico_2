import 'dart:typed_data';

import 'package:desafio_tecnico_2/src/exceptions/exception_handles.dart';
import 'package:desafio_tecnico_2/src/models/book.dart';
import 'package:desafio_tecnico_2/src/pages/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/classes.dart';
import '../../mocks/constants.dart';

void main() {
  final dio = DioMock();
  final repository = BooksRepositoryDioMock(dio);
  final storage = LocalStorageHiveMock();
  final controller = HomeController(repository, storage);
  final bookList = listOfTenBooksMaps.map((e) => Book.fromMap(e)).toList();

  test(
    'deve receber uma lista com 10 "books".',
    () async {
      when(() => storage.getAll()).thenAnswer((_) async => <Book>[]);
      when(() => storage.putAll(any())).thenAnswer((_) => Future.value());
      when(() => repository.getBooks()).thenAnswer((_) async => bookList);
      when(() => repository.getCoverImage(any()))
          .thenAnswer((_) async => Uint8List.fromList([255, 255, 255]));

      await controller.init();

      final books = controller.books;
      expect(books.value.length, equals(10));
    },
  );

  test(
    'deve receber uma mensagem de erro',
    () async {
      when(() => storage.getAll()).thenAnswer((_) async => <Book>[]);
      when(() => storage.putAll(any())).thenAnswer((_) => Future.value());
      when(() => repository.getCoverImage(any()))
          .thenAnswer((_) async => Uint8List.fromList([255, 255, 255]));
      when(() => repository.getBooks())
          .thenAnswer((_) async => throw ExceptionHandled);

      await controller.init();

      final error = controller.error;
      expect(error.value, isNotEmpty);
      //TODO: verificar para as 3 requisições
    },
  );

  test(
    'deve modificar "isLoading" para "true" ao iniciar a requisição',
    () async {
      when(() => storage.getAll()).thenAnswer((_) async => <Book>[]);
      when(() => storage.putAll(any())).thenAnswer((_) => Future.value());
      when(() => repository.getBooks()).thenAnswer((_) async => bookList);
      when(() => repository.getCoverImage(any()))
          .thenAnswer((_) async => Uint8List.fromList([255, 255, 255]));

      final before = controller.isLoading.value;
      controller.init();
      final after = controller.isLoading.value;

      expect(before, isFalse);
      expect(after, isTrue);
    },
  );

  test(
    'deve modificar "isLoading" para "false" ao terminar a requisição',
    () async {
      when(() => storage.getAll()).thenAnswer((_) async => <Book>[]);
      when(() => storage.putAll(any())).thenAnswer((_) => Future.value());
      when(() => repository.getBooks()).thenAnswer((_) async => bookList);
      when(() => repository.getCoverImage(any()))
          .thenAnswer((_) async => Uint8List.fromList([255, 255, 255]));

      final before = controller.isLoading.value;
      await controller.init();
      final after = controller.isLoading.value;

      expect(before, isFalse);
      expect(after, isFalse);
    },
  );
}
