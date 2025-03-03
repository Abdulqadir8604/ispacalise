import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ispacalise/provider/MoyersState.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../util/mAppBar.dart';

class Summary1Page extends StatefulWidget {
  final String type;
  final PageController pageController;

  const Summary1Page({
    super.key,
    required this.type,
    required this.pageController,
  });

  @override
  State<Summary1Page> createState() => _Summary1PageState();
}

class _Summary1PageState extends State<Summary1Page> {
  Map<double, Map<String, double>> moyersChart = {};

  // Load the JSON file and parse it
  Future<void> loadMoyersChart() async {
    try {
      // the json file is in the same folder as this file
      final jsonString = await rootBundle.loadString('assets/data/moyers_chart.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> incisorWidths =
      jsonData["Mixed Dentition Analysis"]["Moyer's Prediction Values"]["Total Mandibular Incisor Width"];

      setState(() {
        moyersChart = {
          for (var item in incisorWidths)
            item["Width"] as double: {
              "Maxilla": item["Predicted Width of Canine and Premolars"]["Maxilla"] as double,
              "Mandible": item["Predicted Width of Canine and Premolars"]["Mandible"] as double,
            }
        };
      });
    } catch (e) {
      log("Error loading Moyer's chart: $e");
    }
  }

  // Get Moyer's prediction based on sum of incisors and arch type
  double getMoyersPrediction(double sumOfIncisors, String type) {
    if (moyersChart.isEmpty) return 0.0; // Fallback if chart isn’t loaded yet

    final arch = type.toLowerCase().contains("mand") ? "Mandible" : "Maxilla";
    if (moyersChart.containsKey(sumOfIncisors)) {
      return moyersChart[sumOfIncisors]![arch]!;
    } else {
      // Linear interpolation for values not in the chart
      final sortedKeys = moyersChart.keys.toList()..sort();
      if (sumOfIncisors < sortedKeys.first) return moyersChart[sortedKeys.first]![arch]!;
      if (sumOfIncisors > sortedKeys.last) return moyersChart[sortedKeys.last]![arch]!;
      for (int i = 0; i < sortedKeys.length - 1; i++) {
        final lowerKey = sortedKeys[i];
        final upperKey = sortedKeys[i + 1];
        if (sumOfIncisors >= lowerKey && sumOfIncisors <= upperKey) {
          final lowerValue = moyersChart[lowerKey]![arch]!;
          final upperValue = moyersChart[upperKey]![arch]!;
          final ratio = (sumOfIncisors - lowerKey) / (upperKey - lowerKey);
          return lowerValue + (upperValue - lowerValue) * ratio;
        }
      }
    }
    return 0.0; // Fallback
  }

  @override
  void initState() {
    super.initState();
    loadMoyersChart().then((_) {
      final state = Provider.of<MoyersState>(context, listen: false);

      final sumOfIncisors = double.tryParse(state.getField("Sum of incisors")) ?? 0.0;
      final moyersPrediction = getMoyersPrediction(sumOfIncisors, widget.type);
      final spaceRequired = sumOfIncisors + (moyersPrediction * 2);

      state.updateField("Moyers prediction", moyersPrediction.toStringAsFixed(2));
      state.updateField("Space required", spaceRequired.toStringAsFixed(2));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MoyersState>(context);

    return PopScope(
      onPopInvoked: (_) {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Scaffold(
        appBar: mAppBar(
          title: 'Moyer\'s Analysis',
          subtitle: widget.type,
          onBack: () {
            widget.pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Moyer’s Prediction for Permanent Canine and Premolars:",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${state.getField("Moyers prediction")} mm",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const Divider(),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Space Required:",
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${state.getField("Space required")} mm",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.resolveWith((states) => const Size(150, 60)),
                      shape: WidgetStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                      backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => Theme.of(context).colorScheme.secondary),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      state.updateField("Moyers prediction", state.getField("Moyers prediction"));
                      state.updateField("Space required", state.getField("Space required"));
                      FocusScope.of(context).unfocus();
                      if (widget.pageController.page?.round() != null &&
                          widget.pageController.page!.round() < 1) {
                        widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.resolveWith((states) => const Size(150, 60)),
                      shape: WidgetStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                      backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => Theme.of(context).colorScheme.primary),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}