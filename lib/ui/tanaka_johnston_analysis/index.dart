import 'package:flutter/material.dart';
import 'package:ispacalise/util/slide_transition.dart';
import 'package:provider/provider.dart';

import '../../provider/TanakaJohnstonState.dart';
import '../../util/mbutton.dart';

class TanakaJohnstonAnalysisPage extends StatefulWidget {
  const TanakaJohnstonAnalysisPage({super.key});

  @override
  State<TanakaJohnstonAnalysisPage> createState() =>
      _TanakaJohnstonAnalysisPageState();
}

class _TanakaJohnstonAnalysisPageState
    extends State<TanakaJohnstonAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text(
          'T & J Analysis',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final state = Provider.of<TanakaJohnstonState>(context, listen: false);
              state.reset();
              setState(() {});
            },
            child: const Text('Reset'),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Introduction: ",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                Text(
                  "To predict the space discrepancy with respect to the eruption of permanent canines an premolars with the help of erupted mandibular incisors.",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                Text("Armanentarium: ",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                Text(
                  "Study model\nScale\nDivider",
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                      fontStyle: FontStyle.italic,
                      color: colorScheme.onSurface),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  padding: const EdgeInsets.all(8),
                  mainAxisSpacing: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  children: [
                    MButton(
                      height: 100,
                      width: 170,
                      onPressed: () {
                        final state = Provider.of<TanakaJohnstonState>(context,
                            listen: false);
                        state.reset();
                        Navigator.push(
                          context,
                          tanakaJohnstonAnalPageRouteBuilder(
                            context,
                            "Mandibular",
                            {
                              // 1st page
                              "1-1": 42,
                              "1-2": 41,
                              "1-3": 31,
                              "1-4": 32,
                              // 2nd page
                              "3-1-1": 85,
                              "3-1-2": 83,
                              "3-2": 83,
                              "3-3": 73,
                              "3-4-1": 73,
                              "3-4-2": 75,
                            },
                          ),
                        );
                      },
                      text: 'Mandibular',
                    ),
                    MButton(
                      height: 100,
                      width: 170,
                      onPressed: () {
                        final state = Provider.of<TanakaJohnstonState>(context,
                            listen: false);
                        state.reset();
                        Navigator.push(
                          context,
                          tanakaJohnstonAnalPageRouteBuilder(
                            context,
                            "Maxillary",
                            {
                              // 1st page
                              "1-1": 42,
                              "1-2": 41,
                              "1-3": 31,
                              "1-4": 32,
                              // 2nd page
                              "3-1-1": 55,
                              "3-1-2": 53,
                              "3-2": 53,
                              "3-3": 63,
                              "3-4-1": 63,
                              "3-4-2": 65,
                            },
                          ),
                        );
                      },
                      text: 'Maxillary',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
