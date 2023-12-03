import 'package:desafio_tecnico_2/src/widgets/app_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const widget = MaterialApp(
    home: _TestAppButtom(),
  );

  testWidgets(
    'deve encontrar um "Text" e um "TextButtom"',
    (tester) async {
      await tester.pumpWidget(widget);

      final buttom = find.byType(TextButton);
      final label = find.byType(Text);

      expect(buttom, findsOneWidget);
      expect(label, findsOneWidget);
    },
  );

  testWidgets(
    'deve verificar a mudança da "label" após o "tap"',
    (tester) async {
      await tester.pumpWidget(widget);

      final textButtom = find.byType(TextButton);
      final finder = find.byType(Text);
      final Text text = tester.widget(finder);
      final label = text.data;

      expect(label, equals('initial'));

      await tester.tap(textButtom);
      await tester.pumpAndSettle();

      final finder2 = find.byType(Text);
      final Text text2 = tester.widget(finder2);
      final label2 = text2.data;
      expect(label2, equals('final'));
    },
  );
}

class _TestAppButtom extends StatefulWidget {
  const _TestAppButtom();

  @override
  State<_TestAppButtom> createState() => _TestAppButtomState();
}

class _TestAppButtomState extends State<_TestAppButtom> {
  String text = 'initial';

  update() {
    setState(() {
      text = 'final';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppButtom(
      label: text,
      onPressed: update,
    );
  }
}
