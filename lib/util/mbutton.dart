import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? color;

  const MButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(
            width: 2,
            color: Colors.transparent,
          ),
        ),
        elevation: WidgetStateProperty.all<double>(10),
        fixedSize: WidgetStateProperty.all<Size>(Size(width ?? 100, height ?? 50)),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
            color ?? Theme.of(context).colorScheme.primary),
        shadowColor: WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}