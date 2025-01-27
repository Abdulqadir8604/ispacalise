import 'package:flutter/material.dart';

class mTextDiv extends StatelessWidget {
  final String text;
  const mTextDiv({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
