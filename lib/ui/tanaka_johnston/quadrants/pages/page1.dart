import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/TanakaJohnstonState.dart';
import '../../../../util/mtextfield.dart';

class Page1 extends StatefulWidget {
  final String type;
  final Map tanakaData;
  final PageController pageController;

  const Page1({
    super.key,
    required this.type,
    required this.pageController, required this.tanakaData,
  });

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final Map<String, TextEditingController> controllers = {};
  late List fields = [];
  @override
  void initState() {
    super.initState();
    // Initialize controllers
    final List<String> fieldLabels = [
      "Mesiodistal width of \$1-1",
      "Mesiodistal width of \$1-2",
      "Mesiodistal width of \$1-3",
      "Mesiodistal width of \$1-4",
    ];
    final tanaData = widget.tanakaData;

    // Replace placeholders in fieldLabels with values from tanaData
    fields = fieldLabels.map((label) {
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
    // Dispose controllers
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  double calculateSum(BuildContext context) {
    double total = 0.0;
    for (var field in fields) {
      total += double.tryParse(controllers[field]?.text ?? "") ?? 0.0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TanakaJohnstonState>(context);
    final sum = calculateSum(context);

    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          "T & J analysis - ${widget.type} - (1)",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            state.reset();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
                setState(() {}); // Update the sum dynamically
              },
            )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sum of Above: $sum",
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: sum > 0
                        ? () {
                      state.updateField("Sum of Above", sum.toString());
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
