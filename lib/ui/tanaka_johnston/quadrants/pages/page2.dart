import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/TanakaJohnstonState.dart';
import '../../../../util/mtextfield.dart';

class Page2 extends StatefulWidget {
  final String type;
  final Map tanakaData;
  final PageController pageController;

  const Page2({
    super.key,
    required this.type,
    required this.pageController, required this.tanakaData,
  });

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final Map<String, TextEditingController> controllers = {};

  late List<String> fields = [];

  @override
  void initState() {
    super.initState();
    final List<String> fieldLabel = [
      "Distal aspect of \$2-1-1 to mesial aspect of \$2-1-2",
      "Mesial aspect of \$2-2 to midline",
      "Midline to mesial of \$2-3",
      "Mesial aspect of \$2-4-1 to distal aspect of \$2-4-2",
    ];
    final tanaData = widget.tanakaData;

    // Replace placeholders in fieldLabel with values from tanaData
    fields = fieldLabel.map((label) {
      tanaData.forEach((key, value) {
        label = label.replaceAll('\$$key', value.toString());
      });
      return label;
    }).toList();

    final state = Provider.of<TanakaJohnstonState>(context, listen: false);
    for (var field in fields) {
      controllers[field] = TextEditingController(text: state.getField(field));
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  double calculateSpace() {
    double total = 0.0;
    for (var field in fields) {
      total += double.tryParse(controllers[field]?.text ?? "") ?? 0.0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TanakaJohnstonState>(context);
    final spaceAvailable = calculateSpace();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "T & J Analysis",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${widget.type} - (2)",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              for (var field in fields) {
                controllers[field]?.clear();
                state.updateField(field, "");
              }
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
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
                "Measure the following on the study model:",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...fields.map((field) => MTextField(
              label: field,
              hint: 'mm',
              controller: controllers[field],
              onChanged: (value) {
                state.updateField(field, value);
                setState(() {}); // Update space available dynamically
              },
            )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Space Available: $spaceAvailable mm",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text("Back"),
                  ),
                  ElevatedButton(
                    onPressed: spaceAvailable > 0
                        ? () {
                      state.updateField(
                        "Space Available",
                        spaceAvailable.toString(),
                      );
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                        : null,
                    child: const Text("Next"),
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
