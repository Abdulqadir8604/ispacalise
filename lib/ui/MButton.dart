import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const MButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        side: WidgetStateProperty.all<BorderSide>(const BorderSide(width: 2)),
        fixedSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary)),
    );
  }
}
