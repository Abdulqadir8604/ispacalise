import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/TanakaJohnstonState.dart';
import '../../../../util/mtextfield.dart';

class Page3 extends StatefulWidget {
  final String type;
  final PageController pageController;

  const Page3({
    super.key,
    required this.type,
    required this.pageController,
  });

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final Map<String, TextEditingController> controllers = {};

  final List<String> fields = [
    "Mesiodistal width of unerupted canine and premolars on right side",
    "Mesiodistal width of unerupted canine and premolars on left side",
    "Space required",
  ];

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TanakaJohnstonState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "T & J Analysis - ${widget.type} - (3)",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          ),
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
                "Measure the following:",
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
              },
            )),
            const SizedBox(height: 20),
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
                    onPressed: () {
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text("Finish"),
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
