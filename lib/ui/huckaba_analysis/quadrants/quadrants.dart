import 'package:flutter/material.dart';
import 'package:ispacalise/util/mAppBar.dart';
import 'package:ispacalise/util/mTextDiv.dart';
import '../../../util/mtextfield.dart';
import '../../../util/mbutton.dart';
import '../service/huckaba_analysis.dart';

class HuckabaQuads extends StatefulWidget {
  final Map<String, Object> hucabaData;

  const HuckabaQuads({super.key, required this.hucabaData});

  @override
  State<HuckabaQuads> createState() => _HuckabaQuadsState();
}

class _HuckabaQuadsState extends State<HuckabaQuads> {
  final TextEditingController x1Controller = TextEditingController();
  final TextEditingController x2Controller = TextEditingController();
  final TextEditingController y2Controller = TextEditingController();

  double y1 = 0.0;
  Map<String, String> report = {};
  String? errorMessage;

  void calculateY1() {
    FocusScope.of(context).unfocus();
    setState(() {
      try {
        errorMessage = null; // Reset error message
        final double x1 = double.tryParse(x1Controller.text) ?? 0.0;
        final double x2 = double.tryParse(x2Controller.text) ?? 0.0;
        final double y2 = double.tryParse(y2Controller.text) ?? 0.0;

        if (x1 == 0 || x2 == 0 || y2 == 0) {
          throw Exception("Please enter valid non-zero values for all fields.");
        }

        final HuckabaService analysis = HuckabaService(x1: x1, x2: x2, y2: y2);
        y1 = analysis.calculateY1();
        report = Map<String, String>.from(analysis.generateReport());
      } catch (e) {
        errorMessage = e.toString();
        y1 = 0.0;
        report = {};
      }
    });
  }

  void resetFields() {
    setState(() {
      x1Controller.clear();
      x2Controller.clear();
      y2Controller.clear();
      y1 = 0.0;
      report = {};
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppBar(
        title: 'Hucaba Analysis',
        subtitle: widget.hucabaData["title"] as String,
        onReset: resetFields,
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const mTextDiv(text: "Measure the following on the study model:"),
            const SizedBox(height: 16),
            MTextField(
              controller: x1Controller,
              label:
                  'Mesiodistal width of ${widget.hucabaData["x1"].toString()}',
              hint: 'mm',
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            const mTextDiv(text: "Measure the following on the study model:"),
            const SizedBox(height: 16),
            MTextField(
              controller: x2Controller,
              label:
                  'Mesiodistal width of ${widget.hucabaData["x2"].toString()}',
              hint: 'mm',
              onChanged: (_) {},
            ),
            MTextField(
              controller: y2Controller,
              label:
                  'Mesiodistal width of ${widget.hucabaData["y2"].toString()}',
              hint: 'mm',
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: MButton(
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                  onPressed: calculateY1,
                  text: 'Calculate',
                  width: 200,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            if (report.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primary,
                child: Text(
                  "Report:",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Space available:",
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
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Apparent Width of Unerupted Premolar:",
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
              ),
              const Divider(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primary,
                child: Text(
                  "Prediction:",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  report["prediction"] ?? "",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
