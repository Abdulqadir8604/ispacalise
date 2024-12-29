// Class to handle Hukaba's formula computation
class HuckabaAnalysis {
  final double x1; // Actual width of the primary molar
  final double x2; // Apparent width of the primary molar
  final double y2; // Apparent width of the unerupted premolar

  HuckabaAnalysis({
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
    return {
      "x1": x1,
      "x2": x2,
      "y2": y2,
      "y1": x1,
      "prediction": x1 > y1
          ? "Adequate space, no regaining needed"
          : "Inadequate space, space regainer required.",
      "spaceAvailable": x1.toStringAsFixed(2),
      "apparentWidthOfUneruptedPremolar": y1.toStringAsFixed(2),
    };
  }
}

// Example usage for all quadrants
void main() {
  // Mandibular Right Quadrant
  HuckabaAnalysis mandibularRight = HuckabaAnalysis(x1: 75, x2: 68, y2: 80);
  print("\n--- Analysis for Mandibular Right Quadrant ---");
  print(mandibularRight.generateReport());

  // Mandibular Left Quadrant
  HuckabaAnalysis mandibularLeft = HuckabaAnalysis(x1: 74, x2: 67, y2: 81);
  print("\n--- Analysis for Mandibular Left Quadrant ---");
  print(mandibularLeft.generateReport());

  // Maxillary Right Quadrant
  HuckabaAnalysis maxillaryRight = HuckabaAnalysis(x1: 72, x2: 66, y2: 79);
  print("\n--- Analysis for Maxillary Right Quadrant ---");
  print(maxillaryRight.generateReport());

  // Maxillary Left Quadrant
  HuckabaAnalysis maxillaryLeft = HuckabaAnalysis(x1: 73, x2: 65, y2: 80);
  print("\n--- Analysis for Maxillary Left Quadrant ---");
  print(maxillaryLeft.generateReport());
}
