import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../models/book.dart';

class BookView extends StatelessWidget {
  const BookView({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
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
                  ClipRect(
                    child: Image.network(
                      book.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: ClipPath(
                      clipper: _Clip(),
                      child: Container(
                        key: Key('favorite-key:${book.id}'),
                        height: 25,
                        width: 15,
                        color: (book.favorite) ? red : white,
                      ),
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
