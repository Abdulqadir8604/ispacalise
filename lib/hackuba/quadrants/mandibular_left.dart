import 'dart:developer';

import 'package:flutter/material.dart';

import '../../service/huckaba.dart';
import '../../ui/MButton.dart';

class MandibularLeftPage extends StatefulWidget {
  const MandibularLeftPage({super.key});

  @override
  State<MandibularLeftPage> createState() => _MandibularLeftPageState();
}

class _MandibularLeftPageState extends State<MandibularLeftPage> {
  TextEditingController x1Controller = TextEditingController();
  TextEditingController x2Controller = TextEditingController();
  TextEditingController y2Controller = TextEditingController();

  double y1 = 0;
  Map report = {};

  String calculateY1() {
    HuckabaAnalysis mandibularLeft = HuckabaAnalysis(
      x1: double.parse(x1Controller.text),
      x2: double.parse(x2Controller.text),
      y2: double.parse(y2Controller.text),
    );
    report = mandibularLeft.generateReport();
    return mandibularLeft.calculateY1().toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Huckaba Analysis: Mandibular Left',
            style: TextStyle(color: Colors.black)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          x1Controller.clear();
          x2Controller.clear();
          y2Controller.clear();
          setState(() {
            y1 = 0;
            report = {};
          });
        },
        child: const Icon(Icons.refresh),
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
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Mesiodistal width of 74",
                  style: TextStyle(fontSize: 20),
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
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Mesiodistal width of 74",
                  style: TextStyle(fontSize: 20),
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
                const Text(
                  "Mesiodistal width of 44",
                  style: TextStyle(fontSize: 20),
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
          MButton(
            onPressed: () {
              setState(() {
                y1 = double.parse(calculateY1());
              });
            },
            text: 'Calculate',
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
                fontSize: 30,
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
                    const Text(
                      "Space available: ",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      report["spaceAvailable"] ?? "",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Apparent Width of Unerupted Premolar: ",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      report["apparentWidthOfUneruptedPremolar"] ?? "",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
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
                fontSize: 30,
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
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
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
