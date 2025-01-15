import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/RadiographicState.dart';
import '../../../../util/mtextfield.dart';

class Page1 extends StatefulWidget {
  final String type;
  final Map radioData;
  final PageController pageController;

  const Page1({
    super.key,
    required this.type,
    required this.pageController,
    required this.radioData,
  });

  @override
  State<Page1> createState() => _Page1State();
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
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          actions: [
            IconButton(
              onPressed: () {
                for (var field in fields) {
                  controllers[field]?.clear();
                  state.updateField('1${widget.type}-$field', "");
                }
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Radiographic Analysis",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${widget.type} - (1)",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                        "Measure the following on the study model:",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
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
