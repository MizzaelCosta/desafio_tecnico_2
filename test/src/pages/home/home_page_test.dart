import 'package:desafio_tecnico_2/src/constants/color.dart';
import 'package:desafio_tecnico_2/src/pages/home/home_controller.dart';
import 'package:desafio_tecnico_2/src/pages/home/home_page.dart';
import 'package:desafio_tecnico_2/src/repositories/api/book_repository.dart';
import 'package:desafio_tecnico_2/src/widgets/app_buttom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../repositories/book_repository_test.dart';

void main() {
  final dio = DioMock();
  final repository = BooksRepositoryDio(dio);
  final controller = HomeController(repository);
  final widget = Provider<HomeController>(
    create: (_) => controller,
    child: const MaterialApp(home: HomePage()),
  );

  testWidgets(
    'deve encontrar a "appBar.backgroundColor" igual a "lilac"',
    (tester) async {
      await tester.pumpWidget(widget);

      final finder = find.byType(AppBar);
      final appBar = tester.widget<AppBar>(finder);

      expect(appBar.backgroundColor, equals(lilac));
    },
  );

  testWidgets(
    'deve encontrar 2(dois) botões na "appBar"',
    (tester) async {
      await tester.pumpWidget(widget);

      final appButtom = find.byType(AppButtom);
      expect(appButtom, findsNWidgets(2));
    },
  );

  testWidgets(
    'description',
    (tester) async {
      final requestOptions = RequestOptions();
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: data, statusCode: 200, requestOptions: requestOptions));

      await tester.pumpWidget(widget);

      final length = controller.books.value.length;
      expect(length, equals(10));
      //TODO: Procurar o "books" na tela
    },
  );

  testWidgets(
    'deve exibir "controller.error" na tela.',
    (tester) async {
      final requestOptions = RequestOptions();
      when(() => dio.get('https://escribo.com/books.json')).thenAnswer(
          (_) async => Response(
              data: data, statusCode: 404, requestOptions: requestOptions));

      await tester.pumpWidget(widget);

      final error = controller.error;
      expect(error.value, equals('Exception: Erro ao carregar.'));
      //TODO: Procurar o "error" na tela
    },
  );
}
