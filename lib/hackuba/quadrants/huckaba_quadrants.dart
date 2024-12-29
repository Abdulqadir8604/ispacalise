import 'dart:developer';

import 'package:flutter/material.dart';

import '../../service/huckaba.dart';
import '../../ui/MButton.dart';

class HuckabaQuads extends StatefulWidget {
  final Map huckabaData;

  const HuckabaQuads({super.key, required this.huckabaData});

  @override
  State<HuckabaQuads> createState() => _HuckabaQuadsState();
}

class _HuckabaQuadsState extends State<HuckabaQuads> {
  TextEditingController x1Controller = TextEditingController();
  TextEditingController x2Controller = TextEditingController();
  TextEditingController y2Controller = TextEditingController();

  double y1 = 0;
  Map report = {};

  String calculateY1() {
    HuckabaAnalysis maxillaryRight = HuckabaAnalysis(
      x1: double.parse(x1Controller.text),
      x2: double.parse(x2Controller.text),
      y2: double.parse(y2Controller.text),
    );
    report = maxillaryRight.generateReport();
    return maxillaryRight.calculateY1().toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text('Huckaba Analysis: ${widget.huckabaData["title"]}',
            style: TextStyle(
                color: Colors.black,
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize)),
        actionsIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        actions: [
          IconButton(
              onPressed: () {
                x1Controller.clear();
                x2Controller.clear();
                y2Controller.clear();
                setState(() {
                  y1 = 0;
                  report = {};
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildInputSection(context),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildReportSection(context),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildInputSection(context),
                      _buildReportSection(context),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.primary,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              "Measure the following on the study model: ",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Mesiodistal width of ${widget.huckabaData["x1"]}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: x1Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'mm',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.primary,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              "Measure the following on the IOPA: ",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Mesiodistal width of ${widget.huckabaData["x2"]}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: x2Controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'mm',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Mesiodistal width of ${widget.huckabaData["y2"]}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: y2Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'mm',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: MButton(
              height: 50,
              width: 200,
              onPressed: () {
                setState(() {
                  y1 = double.parse(calculateY1());
                });
              },
              text: 'Calculate',
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildReportSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.primary,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              "Report: ",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.surface,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Space available: ",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        report["spaceAvailable"] ?? "",
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Apparent Width of Unerupted Premolar: ",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        report["apparentWidthOfUneruptedPremolar"] ?? "",
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.primary,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              "Prediction: ",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.surface,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report["prediction"] ?? "",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall?.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
