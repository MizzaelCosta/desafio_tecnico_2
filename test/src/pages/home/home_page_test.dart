import 'package:desafio_tecnico_2/src/constants/color.dart';
import 'package:desafio_tecnico_2/src/models/book.dart';
import 'package:desafio_tecnico_2/src/pages/home/home_controller.dart';
import 'package:desafio_tecnico_2/src/pages/home/home_page.dart';
import 'package:desafio_tecnico_2/src/pages/read/read_book_controller.dart';
import 'package:desafio_tecnico_2/src/repositories/api/book_repository.dart';
import 'package:desafio_tecnico_2/src/widgets/app_buttom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../mocks/classes.dart';
import '../../mocks/constants.dart';

void main() {
  final dio = DioMock();
  final requestOptions = RequestOptions();
  final apiBooks = BooksRepositoryDio(dio);
  final apiEpub = EpubRepositoryMock();
  final storage = LocalStorageMock();

  testWidgets(
    'deve encontrar a "appBar.backgroundColor" igual a "lilac"',
    (tester) async {
      final home1 = HomeController(apiBooks, storage);
      final read1 = ReadBookController(storage, apiEpub);
      final widget1 = MultiProvider(
        providers: [
          Provider<HomeController>(create: (_) => home1),
          Provider<ReadBookController>(create: (_) => read1),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      );
      await tester.pumpWidget(widget1);

      final finder = find.byType(AppBar);
      final appBar = tester.widget<AppBar>(finder);

      expect(appBar.backgroundColor, equals(lilac));
    },
  );

  testWidgets(
    'deve encontrar 2(dois) botões na "appBar"',
    (tester) async {
      final home2 = HomeController(apiBooks, storage);
      final read2 = ReadBookController(storage, apiEpub);
      final widget2 = MultiProvider(
        providers: [
          Provider<HomeController>(create: (_) => home2),
          Provider<ReadBookController>(create: (_) => read2),
        ],
        child: const MaterialApp(home: HomePage()),
      );

      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: listOfTenBooksMaps,
              statusCode: 200,
              requestOptions: requestOptions));
      await tester.pumpWidget(widget2);

      final appButtom = find.byType(AppButtom);
      expect(appButtom, findsNWidgets(2));
    },
  );

  testWidgets(
    'description',
    (tester) async {
      final home3 = HomeController(apiBooks, storage);
      final read3 = ReadBookController(storage, apiEpub);
      final widget3 = MultiProvider(
        providers: [
          Provider<HomeController>(create: (_) => home3),
          Provider<ReadBookController>(create: (_) => read3),
        ],
        child: const MaterialApp(home: HomePage()),
      );

      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: listOfTenBooksMaps,
              statusCode: 200,
              requestOptions: requestOptions));

      await tester.pumpWidget(widget3);

      final length = home3.books.value.length;
      expect(length, equals(10));
      //TODO: Procurar o "books" na tela
    },
  );

  testWidgets(
    'deve exibir "controller.error" na tela.',
    (tester) async {
      final home4 = HomeController(apiBooks, storage);
      final read4 = ReadBookController(storage, apiEpub);
      final widget4 = MultiProvider(
        providers: [
          Provider<HomeController>(create: (_) => home4),
          Provider<ReadBookController>(create: (_) => read4),
        ],
        child: const MaterialApp(home: HomePage()),
      );

      final requestOptions = RequestOptions();
      final book = Book.empty();
      when(() => storage.getAll()).thenAnswer((_) async => <Book>[]);
      when(() => storage.get(book)).thenAnswer((_) async => Book.empty());
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: listOfTenBooksMaps,
              statusCode: 404,
              requestOptions: requestOptions));

      await tester.pumpWidget(widget4);

      final error = home4.error;
      expect(error.value, isNotEmpty);
      //TODO: verificar para as 3 requisições
      //TODO: Procurar o "error" na tela
    },
  );
}
