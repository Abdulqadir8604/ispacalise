// Class to handle Hukaba's formula computation
class HuckabaService {
  final double x1; // Actual width of the primary molar
  final double x2; // Apparent width of the primary molar
  final double y2; // Apparent width of the unerupted premolar

  HuckabaService({
    required this.x1,
    required this.x2,
    required this.y2,
  });

  // Method to compute Y1 (Apparent width of the unerupted premolar)
  double calculateY1() {
    if (x2 == 0) {
      throw ArgumentError(
          "Apparent width of the primary molar (x2) cannot be zero.");
    }
    return (x1 * y2) / x2;
  }

  // Method to generate a report with the prediction
  Map generateReport() {
    double y1 = calculateY1();
    String prediction;
    if (x1 < y1) {
      prediction = "Inadequate space";
    } else if (x1 == y1) {
      prediction = "Adequate space";
    } else {
      prediction = "Spacing could be seen";
    }
    return {
      "x1": x1.toString(),
      "x2": x2.toString(),
      "y2": y2.toString(),
      "y1": y1.toString(), // Fixed typo here
      "prediction": prediction,
      "spaceAvailable": x1.toStringAsFixed(2),
      "apparentWidthOfUneruptedPremolar": y1.toStringAsFixed(2),
    };
  }
}
