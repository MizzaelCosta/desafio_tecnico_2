import 'package:flutter/material.dart';

import '../../../models/book.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: (book.coverImage == null)
          ? Image.asset('assets/image/cover.png')
          : Image.memory(book.coverImage!),
    );
  }
}
