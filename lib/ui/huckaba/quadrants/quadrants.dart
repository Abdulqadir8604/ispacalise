import 'package:flutter/material.dart';
import '../../../service/huckaba.dart';
import '../../../util/mtextfield.dart';
import '../../../util/mbutton.dart';

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
    setState(() {
      errorMessage = null; // Reset error message
      final double x1 = double.tryParse(x1Controller.text) ?? 0.0;
      final double x2 = double.tryParse(x2Controller.text) ?? 0.0;
      final double y2 = double.tryParse(y2Controller.text) ?? 0.0;

      if (x1 == 0 || x2 == 0 || y2 == 0) {
        throw Exception("Please enter valid non-zero values for all fields.");
      }

      final HuckabaAnalysis analysis = HuckabaAnalysis(x1: x1, x2: x2, y2: y2);
      y1 = analysis.calculateY1();
      report = Map<String, String>.from(analysis.generateReport());
      try {} catch (e) {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text(
          'Hucaba Analysis',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          ),
        ),
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape
              ? Row(
                  children: [
                    Expanded(child: _buildInputSection()),
                    if (report.isNotEmpty)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: _buildReportSection(),
                        ),
                      ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildInputSection(),
                      if (report.isNotEmpty)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: _buildReportSection(),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.hucabaData["title"] as String,
                style: TextStyle(
                  fontSize:
                  Theme.of(context).textTheme.bodyLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildSectionTitle("Measure the following on the study model:"),
        const SizedBox(height: 16),
        MTextField(
          controller: x1Controller,
          label: 'Mesiodistal width of ${widget.hucabaData["x1"].toString()}',
          hint: 'mm',
          onChanged: (_) {},
        ),
        const SizedBox(height: 16),
        _buildSectionTitle("Measure the following on the IOPA:"),
        const SizedBox(height: 16),
        MTextField(
          controller: x2Controller,
          label: 'Mesiodistal width of ${widget.hucabaData["x2"].toString()}',
          hint: 'mm',
          onChanged: (_) {},
        ),
        MTextField(
          controller: y2Controller,
          label: 'Mesiodistal width of ${widget.hucabaData["y2"].toString()}',
          hint: 'mm',
          onChanged: (_) {},
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            child: MButton(
              color: Theme.of(context).colorScheme.tertiary,
              onPressed: calculateY1,
              text: 'Calculate',
              width: 200,
              height: 50,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (errorMessage != null) ...[
          const SizedBox(height: 16),
          Text(
            errorMessage!,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ],
    );
  }

  Widget _buildReportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Report:"),
        const SizedBox(height: 16),
        _buildReportRow("Space available:", report["spaceAvailable"] ?? ""),
        const Divider(),
        _buildReportRow("Apparent Width of Unerupted Premolar:",
            report["apparentWidthOfUneruptedPremolar"] ?? ""),
        const Divider(),
        _buildSectionTitle("Prediction:"),
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        title,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildReportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
