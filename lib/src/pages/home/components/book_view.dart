import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../models/book.dart';
import '../home_controller.dart';
import 'cover_image.dart';
import 'favorite.dart';

class BookView extends StatelessWidget {
  const BookView({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();

    return Card(
      color: white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  CoverImage(book: book),
                  Positioned(
                    right: 0,
                    child: ListenableBuilder(
                      listenable: controller.books,
                      builder: (context, _) {
                        return Favorite(book: book);
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              flex: 1,
              child: Text(
                book.title,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(book.author),
            ),
          ],
        ),
      ),
    );
  }
}
