import 'package:flutter/material.dart';

class TanakaJohnstonState extends ChangeNotifier {
  final Map<String, String> formData = {};

  void updateField(String key, String value) {
    formData[key] = value;
    notifyListeners();
  }

  String getField(String key) => formData[key] ?? '';

  void reset() {
    formData.clear();
    notifyListeners();
  }
}
