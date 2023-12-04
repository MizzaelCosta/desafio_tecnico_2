import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../../repositories/api/book_repository.dart';
import '../../repositories/local/local_storage.dart';

class HomeController {
  HomeController(this._repository, this._storage);

  final BooksRepository _repository;
  final LocalStorageHive _storage;

  final books = ValueNotifier<List<Book>>(<Book>[]);

  final isLoading = ValueNotifier<bool>(false);

  final error = ValueNotifier<String>('');

  final favorite = ValueNotifier<bool>(false);

  Future<void> init() async {
    isLoading.value = true;
    try {
      await _booksFromStorage();
      if (books.value.isEmpty) {
        await _booksFromApi();
        await _booksToStorage();
      }
    } on Exception catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    } catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    }
    isLoading.value = false;
  }

  Future<void> _booksFromStorage() async {
    try {
      _setBooks(await _storage.getAll());
    } on Exception catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    } catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    }
  }

  Future<void> _booksFromApi() async {
    try {
      _setBooks(await _repository.get());
    } on Exception catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    } catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    }
  }

  Future<void> _booksToStorage() async {
    try {
      await _storage.putAll(books.value);
    } on Exception catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    } catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    }
  }

  Future<void> _toStorage(Book book) async {
    try {
      await _storage.put(book);
    } on Exception catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    } catch (e) {
      error.value = e.toString();
      debugPrint(e.toString());
    }
  }

  void _setBooks(List<Book> list) {
    if (favorite.value) {
      final favorites = <Book>[];
      for (var book in list) {
        if (book.favorite) {
          favorites.add(book);
        }
      }
      favorites.sort((a, b) => a.id.compareTo(b.id));
      books.value = favorites;
      return;
    }

    list.sort((a, b) => a.id.compareTo(b.id));
    books.value = list;
  }

  void showFavorite() {
    favorite.value = true;
    _setBooks(books.value);
  }

  void showBooks() async {
    favorite.value = false;
    await _booksFromStorage();
  }

  void setFavorite(Book book) async {
    book = book.copyWith(favorite: !book.favorite);
    await _toStorage(book);
    await _booksFromStorage();
  }

  void dispose() {
    error.dispose();
    isLoading.dispose();
    books.dispose();
  }
}
