import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/TanakaJohnstonState.dart';
import '../../../../util/mAppBar.dart';

class SummaryPage extends StatefulWidget {
  final String type;
  final PageController pageController;

  const SummaryPage({
    super.key,
    required this.type,
    required this.pageController,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  void initState() {
    super.initState();
    final state = Provider.of<TanakaJohnstonState>(context, listen: false);
    final spaceRequired =
        double.tryParse(state.getField("Space Required")) ?? 0.0;
    final spaceAvailable =
        double.tryParse(state.getField("Space Available")) ?? 0.0;
    final arcLengthDiscrepancy = spaceRequired - spaceAvailable;

    state.updateField(
        "Arc length discrepancy", arcLengthDiscrepancy.toString());

    String prediction;
    if (arcLengthDiscrepancy > 0) {
      prediction = "Inadequate space";
    } else if (arcLengthDiscrepancy == 0) {
      prediction = "Adequate space";
    } else {
      prediction = "Spacing could be seen";
    }

    state.updateField("Prediction", prediction);
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TanakaJohnstonState>(context);

    return PopScope(
      onPopInvoked: (_) {
        widget.pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Scaffold(
        appBar:  mAppBar(
          title: "T & J Analysis",
          subtitle: widget.type,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(2.2),
          child: FloatingActionButton(
            onPressed: () {
              state.reset();
              widget.pageController.jumpToPage(0);
            },
            child: const Icon(Icons.refresh),
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
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Report:",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Space Required:",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${double.parse(state.getField("Space Required")).toStringAsFixed(2)} mm",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Space available: ",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${double.parse(state.getField("Space Available")).toStringAsFixed(2)} mm",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Arc length discrepancy: ",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.fontSize,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${double.parse(state.getField("Arc length discrepancy")).toStringAsFixed(2)} mm",
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
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
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Prediction:",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        state.getField("Prediction"),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
