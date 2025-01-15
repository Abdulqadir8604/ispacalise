import 'package:flutter/material.dart';
import 'package:ispacalise/provider/RadiographicState.dart';
import 'package:provider/provider.dart';

class Summary1Page extends StatefulWidget {
  final String type;
  final PageController pageController;

  const Summary1Page({
    super.key,
    required this.type,
    required this.pageController,
  });

  @override
  State<Summary1Page> createState() => _Summary1PageState();
}

class _Summary1PageState extends State<Summary1Page> {
  @override
  void initState() {
    super.initState();
    final state = Provider.of<Radiographicstate>(context, listen: false);
    final X = double.parse(state.getField("X"));
    final X_ = double.parse(state.getField("X'"));
    final Y_ = double.parse(state.getField("Y'"));

    final Y = (X * Y_) / X_;

    state.updateField("Y", Y.toString());

    final sumOfIncisors = state.getField("Sum of incisors");
    final spaceRequired = double.parse(sumOfIncisors) + Y;

    state.updateField("Space required for unerupted canine and premolar", spaceRequired.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<Radiographicstate>(context);

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
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
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
                widget.type,
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
                        "Space required for unerupted canine and premolar:",
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodySmall?.fontSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        state.getField("Space required for unerupted canine and premolar"),
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
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      widget.pageController.nextPage(
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
                        (states) => Theme.of(context)
                            .colorScheme
                            .primary,
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
