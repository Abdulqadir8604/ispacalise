import 'package:flutter/material.dart';
import 'package:ispacalise/provider/MoyersState.dart';
import 'package:ispacalise/util/mAppBar.dart';
import 'package:ispacalise/util/mTextDiv.dart';
import 'package:provider/provider.dart';
import '../../../../util/mtextfield.dart';

class Page2 extends StatefulWidget {
  final String type;
  final Map moyerData;
  final PageController pageController;

  const Page2({
    super.key,
    required this.type,
    required this.pageController,
    required this.moyerData,
  });

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final Map<String, TextEditingController> controllers = {};

  late List fields = [];

  @override
  void initState() {
    super.initState();

    final List<String> fieldLabels = [
      "Distal aspect of \$2-1-1 to Mesial aspect of \$2-1-2",
      "Mesial aspect of \$2-2 to Midline",
      "Midline to Mesial of \$2-3",
      "Mesial aspect of \$2-4-1 to Distal aspect of \$2-4-1",
    ];
    final moyData = widget.moyerData;

    // Replace placeholders in fieldLabels with values from moyData
    fields = fieldLabels.map((label) {
      moyData.forEach((key, value) {
        label = label.replaceAll('\$$key', value.toString());
      });
      return label;
    }).toList();

    for (var field in fields) {
      controllers[field] = TextEditingController(
          text: Provider.of<MoyersState>(context, listen: false)
              .getField('2${widget.type}-$field'));
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
    final state = Provider.of<MoyersState>(context);
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
          title: 'Moyer\'s Analysis',
          subtitle: "${widget.type} - (2)",
          onReset: () {
            for (var field in fields) {
              controllers[field]?.clear();
              state.updateField('1${widget.type}-$field', "");
            }
            setState(() {});
          },
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
                    const mTextDiv(text: "Measure the following on the study model:"),
                    const SizedBox(height: 20),
                    ...fields.map((field) => MTextField(
                          label: field,
                          hint:
                              'mm ${field.split(' ').sublist(field.split(' ').length - 2).join(' ')}',
                          controller: controllers[field],
                          onChanged: (value) {
                            state.updateField('2${widget.type}-$field', value);
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
