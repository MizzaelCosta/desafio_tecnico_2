import 'package:flutter/material.dart';

class AppButtom extends StatelessWidget {
  const AppButtom({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        shape: MaterialStatePropertyAll(LinearBorder()),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
