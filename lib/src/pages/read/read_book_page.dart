import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late ReadBookController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<ReadBookController>()..get(widget.book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: Listenable.merge(
          [
            _controller.bookContent,
            _controller.isLoading,
            _controller.error,
          ],
        ),
        builder: (__, _) {
          if (_controller.isLoading.value) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('carregendo...'),
                  SizedBox(height: 16),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          if (_controller.error.value.isNotEmpty) {
            return Center(
              child: Expanded(child: Text(_controller.error.value)),
            );
          }
          return EpubView(
            controller: EpubController(
              document:
                  EpubDocument.openData(_controller.bookContent.value.epub!),
            ),
          );
        },
      ),
    );
  }
}
