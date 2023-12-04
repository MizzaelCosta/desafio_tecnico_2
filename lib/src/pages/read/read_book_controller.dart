import 'package:desafio_tecnico_2/src/repositories/api/epub_repository.dart';
import 'package:desafio_tecnico_2/src/repositories/local/local_storage.dart';
import 'package:flutter/material.dart';

import '../../models/book.dart';

class ReadBookController {
  ReadBookController(
    this._storage,
    this._repository,
  );

  final LocalStorage _storage;
  final EpubRepository _repository;

  final bookContent = ValueNotifier<Book>(Book.empty());

  final isLoading = ValueNotifier<bool>(false);

  final error = ValueNotifier<String>('');

  Future<void> get(Book book) async {
    isLoading.value = true;
    try {
      final fromStorage = await _storage.get(book);

      if (fromStorage?.epub == null) {
        final epub = await _repository.get(book.download_url);
        bookContent.value = book.copyWith(epub: epub);

        await _storage.put(bookContent.value);
      } else {
        bookContent.value = book.copyWith(epub: fromStorage?.epub);
      }
      //
    } on Exception catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    } catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    }
    isLoading.value = false;
  }

  void dispose() {
    error.dispose();
    isLoading.dispose();
    bookContent.dispose();
  }
}
