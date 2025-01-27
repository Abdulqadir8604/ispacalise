import 'package:flutter/material.dart';
import 'package:ispacalise/provider/RadiographicState.dart';
import 'package:ispacalise/util/mTextDiv.dart';
import 'package:provider/provider.dart';
import '../../../../util/mAppBar.dart';
import '../../../../util/mtextfield.dart';

class Page2 extends StatefulWidget {
  final String type;
  final Map radioData;
  final PageController pageController;

  const Page2({
    super.key,
    required this.type,
    required this.pageController,
    required this.radioData,
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
      "Mesiodistal width of \$2-1",
      "Mesiodistal width of \$2-2",
      "Mesiodistal width of \$2-3",
      "Mesiodistal width of \$2-4",
      "Mesiodistal width of \$2-5",
      "Mesiodistal width of \$2-6",
    ];
    final radData = widget.radioData;

    // Replace placeholders in fieldLabels with values from radData
    fields = fieldLabels.map((label) {
      radData.forEach((key, value) {
        label = label.replaceAll('\$$key', value.toString());
      });
      return label;
    }).toList();

    for (var field in fields) {
      controllers[field] = TextEditingController(
          text: Provider.of<RadiographicState>(context, listen: false)
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
          subtitle: "${widget.type} - (2)",
          onBack: () {
            widget.pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          onReset: () {
            for (var field in fields) {
              controllers[field]?.clear();
              state.updateField('2${widget.type}-$field', "");
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
                          "X", sum.toString());
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
