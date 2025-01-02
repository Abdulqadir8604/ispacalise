import 'package:flutter/material.dart';

class MTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final double? labelSize;
  final Null Function(dynamic _) onChanged;
  const MTextField({super.key, required this.controller, required this.label, required this.hint, required this.onChanged, this.labelSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: TextInputType.number,
        onTapOutside: (focus) {
          // FocusScope.of(context).requestFocus(FocusNode());
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: labelSize ?? Theme.of(context).textTheme.bodyLarge?.fontSize,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
