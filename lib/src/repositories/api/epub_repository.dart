import 'dart:typed_data';

import 'package:internet_file/internet_file.dart';

abstract class EpubRepository {
  Future<Uint8List> get(String url);
}

class EpubRepositoryImpl implements EpubRepository {
  @override
  Future<Uint8List> get(String url) async {
    final epub = await InternetFile.get(url);

    return epub;
  }
}
