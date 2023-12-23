import 'package:flutter/material.dart';

import '../../exceptions/exception_handles.dart';
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
    await _booksFromStorage();
    if (books.value.isEmpty) {
      await _booksFromApi();
      if (books.value.isNotEmpty) {
        await _toStorageAll(books.value);
      }
    }
    isLoading.value = false;
    _setCoverImage(books.value);
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
      _setBooks(await _repository.getBooks());
    } on ExceptionHandled catch (exception) {
      error.value = exception.message;
      debugPrint(exception.toString());
    } catch (e) {
      //TODO: mandar pro crashlytics
      //Se recebido erro não esperado
      //não tratar. Enviá-lo!
      error.value = e.toString();
      debugPrint(e.toString());
    }
  }

  Future<void> _toStorageAll(List<Book> list) async {
    try {
      await _storage.putAll(list);
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

  void _sortList(List<Book> list) {
    list.sort((a, b) => a.id.compareTo(b.id));
  }

  void _setBooks(List<Book> list) {
    if (favorite.value) {
      final favorites = <Book>[];
      for (var book in list) {
        if (book.favorite) {
          favorites.add(book);
        }
      }
      _sortList(favorites);
      books.value = favorites;
      return;
    }
    _sortList(list);
    books.value = list;
  }

  void showFavorite() {
    if (!favorite.value) {
      favorite.value = true;
      _setBooks(books.value);
    }
  }

  void showBooks() async {
    if (favorite.value) {
      favorite.value = false;
      await _booksFromStorage();
    }
  }

  void setFavorite(Book book) async {
    book = book.copyWith(favorite: !book.favorite);
    await _toStorage(book);
    final list = books.value.map((e) {
      if (e.id == book.id) {
        e = e.copyWith(favorite: !e.favorite);
      }
      return e;
    }).toList();
    _setBooks(list);
  }

  void dispose() {
    error.dispose();
    isLoading.dispose();
    books.dispose();
  }

  Stream<List<Book>> _getImage(List<Book> list) async* {
    for (Book e in list) {
      yield [
        e.copyWith(coverImage: await _repository.getCoverImage(e.cover_url))
      ];
    }
  }

  void _setCoverImage(List<Book> list) async {
    final stream = _getImage(list);
    await for (final strm in stream) {
      _toStorageAll(strm);

      final coverInserted = books.value.map((book) {
        if (book.title == strm.first.title) {
          book = book.copyWith(coverImage: strm.first.coverImage);
        }
        return book;
      }).toList();
      _setBooks(coverInserted);
    }
  }
}
