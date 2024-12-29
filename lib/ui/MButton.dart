import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  const MButton({super.key, required this.onPressed, required this.text, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        side: WidgetStateProperty.all<BorderSide>(const BorderSide(width: 2)),
        fixedSize: WidgetStateProperty.all<Size>( Size(width, height)),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          color: Theme.of(context).colorScheme.onPrimary)),
    );
  }
}
