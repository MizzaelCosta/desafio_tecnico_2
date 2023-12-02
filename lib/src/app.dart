import 'package:desafio_tecnico_2/src/pages/read/read_book_controller.dart';
import 'package:desafio_tecnico_2/src/repositories/api/epub_repository.dart';
import 'package:desafio_tecnico_2/src/repositories/local/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home/home_controller.dart';
import 'pages/home/home_page.dart';
import 'repositories/api/book_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeController>(
            create: (_) => HomeController(BooksRepositoryDio(Dio()))),
        Provider<ReadBookController>(
            create: (_) =>
                ReadBookController(LocalStorageHive(), EpubRepositoryImpl())),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
