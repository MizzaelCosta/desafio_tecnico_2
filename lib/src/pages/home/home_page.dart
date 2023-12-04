import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../widgets/app_buttom.dart';
import '../read/read_book_controller.dart';
import '../read/read_book_page.dart';
import 'components/book_view.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;
  late ReadBookController _dispose;

  @override
  void initState() {
    super.initState();
    _controller = context.read<HomeController>()..init();
    _dispose = context.read<ReadBookController>();
  }

  @override
  void dispose() {
    _dispose.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: adicionar um "LayoutBuilder" para
    //gerenciar o numero de colunas no "GridView.builder"
    //ao rotacionar a tela.
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            AppButtom(
              label: 'Livros',
              onPressed: () {
                _controller.showBooks();
              },
            ),
            AppButtom(
              label: 'Favoritos',
              onPressed: () {
                _controller.showFavorite();
              },
            ),
          ],
        ),
        backgroundColor: lilac,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListenableBuilder(
          listenable: Listenable.merge(
            [
              _controller.books,
              _controller.isLoading,
              _controller.error,
              _controller.favorite,
            ],
          ),
          builder: (__, _) {
            if (_controller.isLoading.value) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Baixando...'),
                    SizedBox(height: 16),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
            if (_controller.error.value.isNotEmpty) {
              return Center(
                child: Expanded(child: Text(_controller.error.value)),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: _controller.books.value.length,
              itemBuilder: (_, index) {
                debugPrint('GridView.builder');
                final book = _controller.books.value[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReadBookPage(book),
                      ),
                    );
                  },
                  child: BookView(book: book),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
