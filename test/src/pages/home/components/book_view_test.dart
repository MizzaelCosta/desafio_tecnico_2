import 'package:desafio_tecnico_2/src/constants/color.dart';
import 'package:desafio_tecnico_2/src/models/book.dart';
import 'package:desafio_tecnico_2/src/pages/home/components/book_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  final book = Book.fromMap(map);

  final widget = MaterialApp(
    home: Scaffold(
      body: BookView(
        book: book,
      ),
    ),
  );

  testWidgets(
    'deve encontar o título e o autor do livro',
    (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(widget);

        final titleFinder = find.text(book.title);
        final title = tester.widget<Text>(titleFinder).data;
        final authorFinder = find.text(book.author);
        final author = tester.widget<Text>(authorFinder).data;

        expect(title, equals("The Bible of Nature"));
        expect(author, equals("Oswald, Felix L."));
      });
    },
  );

  testWidgets(
    'deve encontrar a capa do livro',
    (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(widget);

        final image = find.byType(Image);
        expect(image, findsOneWidget);
      });
    },
  );

  testWidgets(
    'deve encontrar um card de "color" branca com "elevation" igual a 0(zero)',
    (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(widget);

        final finder = find.byType(Card);
        final card = tester.widget<Card>(finder);

        expect(finder, findsOneWidget);
        expect(card.color, equals(white));
        expect(card.elevation, equals(0));
      });
    },
  );

  group(
    'testa a marcação de favoritos',
    () {
      testWidgets(
        'deve encotrar a posição "rigth: 0" para a marcação de favorito',
        (tester) async {
          await mockNetworkImages(() async {
            await tester.pumpWidget(widget);

            final finder = find.byType(Positioned);
            final positioned = tester.widget<Positioned>(finder);

            expect(finder, findsOneWidget);
            expect(positioned.right, equals(0));
          });
        },
      );

      testWidgets(
        'deve encontrar a cor branca na marcação de favorito(favorite: falso)',
        (tester) async {
          await mockNetworkImages(() async {
            await tester.pumpWidget(widget);

            final key = Key('favorite-key:${book.id}');
            final finder = find.byKey(key);
            final container = tester.widget<Container>(finder);

            expect(finder, findsOneWidget);
            expect(container.color, equals(white));
          });
        },
      );

      testWidgets(
        'deve encontrar a cor vermelha na marcação de favorito(favorite: true)',
        (tester) async {
          final favorite = book.copyWith(id: 2, favorite: true);
          final widget2 = MaterialApp(
            home: BookView(
              book: favorite,
            ),
          );

          await mockNetworkImages(() async {
            await tester.pumpWidget(widget2);
            final key = Key('favorite-key:${favorite.id}');
            final finder = find.byKey(key);
            final container = tester.widget<Container>(finder);

            expect(finder, findsOneWidget);
            expect(container.color, equals(red));
          });
        },
      );
    },
  );
}

const map = {
  "id": 1,
  "title": "The Bible of Nature",
  "author": "Oswald, Felix L.",
  "cover_url":
      "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg",
  "download_url": "https://www.gutenberg.org/ebooks/72134.epub3.images"
};
