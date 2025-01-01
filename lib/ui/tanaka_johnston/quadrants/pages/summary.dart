import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/TanakaJohnstonState.dart';

class SummaryPage extends StatelessWidget {
  final String type;
  final PageController pageController;

  const SummaryPage({
    super.key,
    required this.type,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TanakaJohnstonState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "T & J Analysis - $type - Report",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          state.reset();
          pageController.jumpToPage(0);
        },
        child: const Icon(Icons.refresh),
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
                "Report:",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Space required: ${state.getField("Space required")} mm",
                    style: TextStyle(
                      fontSize:
                      Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                  Text(
                    "Space available: ${state.getField("Space Available")} mm",
                    style: TextStyle(
                      fontSize:
                      Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                  Text(
                    "Arc length discrepancy: ${state.getField("Arc length discrepancy")} mm",
                    style: TextStyle(
                      fontSize:
                      Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                ],
              ),
            ),
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
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(8),
              child: Text(
                state.getField("Prediction"),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
