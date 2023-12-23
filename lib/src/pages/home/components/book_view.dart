import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../models/book.dart';
import '../home_controller.dart';

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
                  ClipRRect(
                    child: (book.coverImage == null)
                        ? Image.asset('assets/image/cover.png')
                        : Image.memory(book.coverImage!),
                  ),
                  Positioned(
                    right: 0,
                    child: ListenableBuilder(
                      listenable: controller.books,
                      builder: (context, _) {
                        return GestureDetector(
                          child: ClipPath(
                            clipper: _Clip(),
                            child: Container(
                              key: Key('favorite-key:${book.id}'),
                              height: 35,
                              width: 25,
                              color: (book.favorite) ? red : white,
                            ),
                          ),
                          onTap: () {
                            controller.setFavorite(book);
                          },
                        );
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

class _Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final m = size.width / 2;
    final h = size.height;
    final w = size.width;
    final b = h - m;

    path
      ..lineTo(0, b) //2
      ..lineTo(m, h) //3
      ..lineTo(w, b) //4
      ..lineTo(w, 0) //5
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
