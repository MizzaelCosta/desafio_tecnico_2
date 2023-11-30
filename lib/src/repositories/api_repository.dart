import '../models/book.dart';

abstract class BooksRepository {
  Future<List<Book>> get();
}
