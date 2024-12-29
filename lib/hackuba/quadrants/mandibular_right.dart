import 'dart:developer';

import 'package:flutter/material.dart';

import '../../service/huckaba.dart';
import '../../ui/MButton.dart';

class MandibularRightPage extends StatefulWidget {
  const MandibularRightPage({super.key});

  @override
  State<MandibularRightPage> createState() => _MandibularRightPageState();
}

class _MandibularRightPageState extends State<MandibularRightPage> {
  TextEditingController x1Controller = TextEditingController();
  TextEditingController x2Controller = TextEditingController();
  TextEditingController y2Controller = TextEditingController();

  double y1 = 0;
  Map report = {};

  String calculateY1() {
    HuckabaAnalysis mandibularRight = HuckabaAnalysis(
      x1: double.parse(x1Controller.text),
      x2: double.parse(x2Controller.text),
      y2: double.parse(y2Controller.text),
    );
    report = mandibularRight.generateReport();
    return mandibularRight.calculateY1().toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Huckaba Analysis: Mandibular Right',
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
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
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
                  "Measure the following on the study model: ",
                  style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Mesiodistal width of 84",
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
                          "Mesiodistal width of 84",
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              report["spaceAvailable"] ?? "",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            report["apparentWidthOfUneruptedPremolar"] == null
                                ? const Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    double.parse(report[
                                            "apparentWidthOfUneruptedPremolar"])
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
