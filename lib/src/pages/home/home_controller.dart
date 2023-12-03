import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../../repositories/api/book_repository.dart';

class HomeController {
  HomeController(this._repository);

  final BooksRepository _repository;

  final books = ValueNotifier<List<Book>>(<Book>[]);

  final isLoading = ValueNotifier<bool>(false);

  final error = ValueNotifier<String>('');

  Future<void> get() async {
    isLoading.value = true;
    try {
      books.value = await _repository.get();
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
    books.dispose();
  }
}
