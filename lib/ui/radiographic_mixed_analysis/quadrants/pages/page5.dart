import 'package:flutter/material.dart';
import 'package:ispacalise/provider/RadiographicState.dart';
import 'package:ispacalise/util/mTextDiv.dart';
import 'package:provider/provider.dart';
import '../../../../util/mAppBar.dart';
import '../../../../util/mtextfield.dart';

class Page5 extends StatefulWidget {
  final String type;
  final Map radioData;
  final PageController pageController;

  const Page5({
    super.key,
    required this.type,
    required this.pageController,
    required this.radioData,
  });

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  final Map<String, TextEditingController> controllers = {};

  late List<String> fields = [];

  @override
  void initState() {
    super.initState();
    final List<String> fieldLabel = [
      "Distal aspect of \$5-1-1 to Mesial aspect of \$5-1-2",
      "Mesial aspect of \$5-2 to midline",
      "C Midline to mesial aspect of \$5-3",
      "D Mesial aspect of \$5-4-1 to Distal aspect of \$5-4-2",
    ];
    final radData = widget.radioData;

    // Replace placeholders in fieldLabel with values from radData
    fields = fieldLabel.map((label) {
      radData.forEach((key, value) {
        label = label.replaceAll('\$$key', value.toString());
      });
      return label;
    }).toList();

    final state = Provider.of<RadiographicState>(context, listen: false);
    for (var field in fields) {
      controllers[field] = TextEditingController(text: state.getField('5${widget.type}-$field'));
    }
  }

  @override
  void dispose() {
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
    final state = Provider.of<RadiographicState>(context);
    final sum = calculateSum(context);

    return PopScope(
      onPopInvoked: (_) {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Scaffold(
        appBar: mAppBar(
          title: 'Radio Analysis',
          subtitle: "${widget.type} - (5)",
          onBack: () {
            widget.pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          onReset: () {
            for (var field in fields) {
              controllers[field]?.clear();
              state.updateField('5${widget.type}-$field', "");
            }
            setState(() {});
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
                    const mTextDiv(text: "Measure the following on the study model:"),
                    const SizedBox(height: 20),
                    ...fields.map((field) => MTextField(
                          label: field,
                          hint: 'mm',
                          controller: controllers[field],
                          onChanged: (value) {
                            state.updateField('5${widget.type}-$field', value);
                            setState(
                                () {});
                          },
                        )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Space available: ${sum.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                      fixedSize: WidgetStateProperty.resolveWith(
                        (states) => const Size(150, 60),
                      ),
                      shape: WidgetStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
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
                    onPressed: sum > 0
                        ? () {
                      FocusScope.of(context).unfocus();
                      state.updateField(
                          "Space available", sum.toString());
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                        : null,
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.resolveWith(
                            (states) => const Size(150, 60),
                      ),
                      shape: WidgetStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.resolveWith(
                            (states) => sum > 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                      ),
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
