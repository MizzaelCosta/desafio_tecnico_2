import 'package:desafio_tecnico_2/src/models/book.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<Book?> get(Book book);
  Future<void> put(Book book);
}

class LocalStorageHive extends LocalStorage {
  final boxName = 'epub-key';

  @override
  Future<Book?> get(Book book) async {
    final key = book.title;
    final storage = await Hive.openBox(boxName);
    final map = await storage.get(key);
    if (map == null) {
      return null;
    }

    return Book.fromMap(map);
  }

  Future<List<Book>> getAll() async {
    final storage = await Hive.openBox(boxName);
    final list = (storage.values).map((e) => Book.fromMap(e)).toList();

    return list;
  }

  @override
  Future<void> put(Book book) async {
    final storage = await Hive.openBox(boxName);
    final key = book.title;
    final map = book.toMap();

    await storage.put(key, map);
  }

  Future<void> putAll(List<Book> list) async {
    for (var book in list) {
      await put(book);
    }
  }
}
