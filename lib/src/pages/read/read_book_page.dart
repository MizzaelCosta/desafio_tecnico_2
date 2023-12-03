import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../models/book.dart';
import 'read_book_controller.dart';

class ReadBookPage extends StatefulWidget {
  const ReadBookPage(
    this.book, {
    super.key,
  });

  final Book book;
  @override
  State<ReadBookPage> createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  late ReadBookController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ReadBookController>()..get(widget.book);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lilac,
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
          [
            controller.bookContent,
            controller.isLoading,
            controller.error,
          ],
        ),
        builder: (__, _) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.error.value.isNotEmpty) {
            return Center(
              child: Expanded(child: Text(controller.error.value)),
            );
          }
          return EpubView(
            controller: EpubController(
                document:
                    EpubDocument.openData(controller.bookContent.value.epub)),
          );
        },
      ),
    );
  }
}
