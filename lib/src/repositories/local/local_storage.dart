import 'dart:typed_data';

import 'package:desafio_tecnico_2/src/models/book.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future get(Book book);
  Future<void> put(Book book);
}

class LocalStorageHive extends LocalStorage {
  final boxName = 'epub-key';

  @override
  Future<Uint8List?> get(Book book) async {
    final storage = await Hive.openBox(boxName);
    final epub = storage.get(book.download_url);
    if (epub == null) {
      return null;
    }

    return epub;
  }

  @override
  Future<void> put(Book book) async {
    final storage = await Hive.openBox(boxName);

    storage.put(book.download_url, book.epub);
  }
}
