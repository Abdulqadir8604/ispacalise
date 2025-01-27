import 'package:flutter/material.dart';
import 'package:ispacalise/util/mAppBar.dart';
import 'package:provider/provider.dart';

import '../../../../provider/TanakaJohnstonState.dart';
import '../../../../util/mTextDiv.dart';
import '../../../../util/mtextfield.dart';

class Page1 extends StatefulWidget {
  final String type;
  final Map tanakaData;
  final PageController pageController;

  const Page1({
    super.key,
    required this.type,
    required this.pageController,
    required this.tanakaData,
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

    for (var field in fields) {
      controllers[field] = TextEditingController(
          text: Provider.of<TanakaJohnstonState>(context, listen: false)
              .getField('1${widget.type}-$field'));
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

    return PopScope(
      onPopInvoked: (_) {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Scaffold(
        appBar: mAppBar(
          title: "T & J Analysis",
          subtitle: "${widget.type} - (1)",
          onBack: () {
            Navigator.pop(context);
          },
          onReset: () {
            for (var field in fields) {
              controllers[field]?.clear();
              state.updateField('1${widget.type}-$field', "");
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
                    ...fields.map((field) => MTextField(
                          label: field,
                          hint: 'mm',
                          controller: controllers[field],
                          onChanged: (value) {
                            state.updateField('1${widget.type}-$field', value);
                            setState(() {});
                          },
                        )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sum of Above: ${sum.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: sum > 0
                        ? () {
                            FocusScope.of(context).unfocus();
                            state.updateField(
                                "Sum of incisors", sum.toString());
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
