import 'package:flutter/material.dart';


class RadiographicState extends ChangeNotifier {
  final Map<String, String> formData = {};
  final Map<String, dynamic> mandibularReport = {};
  final Map<String, dynamic> maxillaryReport = {};

  void updateField(String key, String value) {
    formData[key] = value;
    notifyListeners();
  }

  String getField(String key) => formData[key] ?? '';

  void reset() {
    formData.clear();
    mandibularReport.clear();
    maxillaryReport.clear();
    notifyListeners();
  }
}
