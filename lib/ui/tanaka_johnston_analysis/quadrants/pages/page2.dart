import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/TanakaJohnstonState.dart';
import '../../../../util/mtextfield.dart';

class Page2 extends StatefulWidget {
  final String type;
  final PageController pageController;

  const Page2({
    super.key,
    required this.type,
    required this.pageController,
  });

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final Map<String, TextEditingController> controllers = {};

  final List<String> fields = [
    "Mesiodistal width of unerupted canine and premolars on right side",
    "Mesiodistal width of unerupted canine and premolars on left side",
    "Space Required",
  ];

  @override
  void initState() {
    super.initState();
    final state = Provider.of<TanakaJohnstonState>(context, listen: false);
    for (var field in fields) {
      controllers[field] = TextEditingController(text: state.getField('2${widget.type}-$field'));
    }

    // Fetch the data from the previous page that is the incisor sum
    final incisorSum =
        double.tryParse(state.getField("Sum of incisors")) ?? 0.0;

    double rightSide, leftSide, spaceRequired;
    if (widget.type == "Mandibular") {
      rightSide = (incisorSum / 2) + 10.5;
      leftSide = rightSide;
      spaceRequired = incisorSum + rightSide + leftSide;
    } else {
      rightSide = (incisorSum / 2) + 11;
      leftSide = rightSide;
      spaceRequired = incisorSum + rightSide + leftSide;
    }

    state.updateField(
        "Mesiodistal width of unerupted canine and premolars on right side",
        rightSide.toString());
    state.updateField(
        "Mesiodistal width of unerupted canine and premolars on left side",
        leftSide.toString());
    state.updateField("Space Required", spaceRequired.toString());

    controllers[
            "Mesiodistal width of unerupted canine and premolars on right side"]
        ?.text = rightSide.toString();
    controllers[
            "Mesiodistal width of unerupted canine and premolars on left side"]
        ?.text = leftSide.toString();
    controllers["Space Required"]?.text = spaceRequired.toString();
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "T & J Analysis",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${widget.type} - (2)",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                for (var field in fields) {
                  controllers[field]?.clear();
                  state.updateField('2${widget.type}-$field', "");
                }
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          automaticallyImplyLeading: false,
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
                        "Measure the following:",
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
                          hint:
                              'mm ${field.split(' ').sublist(field.split(' ').length - 2).join(' ')}',
                          controller: controllers[field],
                          onChanged: (value) {
                            state.updateField('2${widget.type}-$field', value);
                          },
                        )),
                    const SizedBox(height: 20),
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
                      // save the data under certain names
                      state.updateField(
                          "2-1",
                          controllers["Mesiodistal width of unerupted canine and premolars on right side"]
                                  ?.text ??
                              "");
                      state.updateField(
                          "2-2",
                          controllers["Mesiodistal width of unerupted canine and premolars on left side"]
                                  ?.text ??
                              "");
                      state.updateField(
                          "2-3", controllers["Space Required"]?.text ?? "");
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
                          (states) => Theme.of(context).colorScheme.primary),
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
