import 'package:flutter/foundation.dart';

import '../service/huckaba.dart';

class HuckabaState extends ChangeNotifier {
  double _x1 = 0.0;
  double _x2 = 0.0;
  double _y2 = 0.0;
  double _y1 = 0.0;
  Map<String, String> _report = {};

  double get x1 => _x1;
  double get x2 => _x2;
  double get y2 => _y2;
  double get y1 => _y1;
  Map<String, String> get report => _report;

  void updateX1(double value) {
    _x1 = value;
    notifyListeners();
  }

  void updateX2(double value) {
    _x2 = value;
    notifyListeners();
  }

  void updateY2(double value) {
    _y2 = value;
    notifyListeners();
  }

  void calculateY1() {
    if (_x1 > 0 && _x2 > 0 && _y2 > 0) {
      final analysis = HuckabaAnalysis(x1: _x1, x2: _x2, y2: _y2);
      _y1 = double.parse(analysis.calculateY1().toStringAsFixed(2));
      _report = Map<String, String>.from(analysis.generateReport());
      notifyListeners();
    }
  }

  void reset() {
    _x1 = 0.0;
    _x2 = 0.0;
    _y2 = 0.0;
    _y1 = 0.0;
    _report = {};
    notifyListeners();
  }
}
