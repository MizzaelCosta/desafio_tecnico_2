import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var diretory = await getApplicationDocumentsDirectory();
  Hive.init(diretory.path);

  runApp(const App());
}
