import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color.dart';
import '../../widgets/app_buttom.dart';
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
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<HomeController>()..get();
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
              onPressed: () {},
            ),
            AppButtom(
              label: 'Favoritos',
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: lilac,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedBuilder(
          animation: Listenable.merge(
            [
              controller.books,
              controller.isLoading,
              controller.error,
            ],
          ),
          builder: (__, _) {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.error.value.isNotEmpty) {
              return Center(
                child: Expanded(
                    child: Text(
                        key: const Key('error-key'), controller.error.value)),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: controller.books.value.length,
              itemBuilder: (_, index) {
                debugPrint('GridView.builder');
                final book = controller.books.value[index];

                return BookView(book: book);
              },
            );
          },
        ),
      ),
    );
  }
}
