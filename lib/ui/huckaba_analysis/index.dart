import 'package:flutter/material.dart';
import 'package:ispacalise/provider/HuckabaState.dart';
import 'package:ispacalise/util/mAppBar.dart';
import 'package:ispacalise/util/slide_transition.dart';
import 'package:provider/provider.dart';

import '../../util/mbutton.dart';
import 'quadrants/quadrants.dart';

class HuckabaAnalysisPage extends StatefulWidget {
  const HuckabaAnalysisPage({super.key});

  @override
  State<HuckabaAnalysisPage> createState() => _HuckabaAnalysisPageState();
}

class _HuckabaAnalysisPageState extends State<HuckabaAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: mAppBar(
        title: 'Huckaba Analysis',
        onBack: () {
          Navigator.pop(context);
        },
        onReset: () {
          final state = Provider.of<HuckabaState>(context, listen: false);
          state.reset();
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Introduction: ",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.fontSize,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        Text(
                          "To predict the space discrepancy with regards to unerupted first premolars while planning a unilateral space maintainer with the help of IOPA.",
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge?.fontSize,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Armanentarium: ",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.fontSize,
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        Text(
                          "Study model\nScale\nDivider\nIOPA of the quadrant in which space maintainer(unilateral) is planned",
                          style: TextStyle(
                              fontSize:
                                  Theme.of(context).textTheme.bodyLarge?.fontSize,
                              fontStyle: FontStyle.italic,
                              color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  mainAxisSpacing: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  children: [
                    MButton(
                      onPressed: () {
                        // final state =
                        //     Provider.of<HuckabaState>(context, listen: false);
                        // state.reset();
                        Navigator.push(
                          context,
                          hucabaAnalPageRouteBuilder(context, {
                            "x1": 54,
                            "x2": 54,
                            "y2": 14,
                            "title": "Maxillary Right"
                          }),
                        );
                      },
                      text: 'Maxillary Right',
                    ),
                    MButton(
                      onPressed: () {
                        // final state =
                        //     Provider.of<HuckabaState>(context, listen: false);
                        // state.reset();
                        Navigator.push(
                          context,
                          hucabaAnalPageRouteBuilder(context, {
                            "x1": 64,
                            "x2": 64,
                            "y2": 24,
                            "title": "Maxillary Left"
                          }),
                        );
                      },
                      text: 'Maxillary Left',
                    ),
                    MButton(
                      onPressed: () {
                        // final state =
                        //     Provider.of<HuckabaState>(context, listen: false);
                        // state.reset();
                        Navigator.push(
                          context,
                          hucabaAnalPageRouteBuilder(context, {
                            "x1": 84,
                            "x2": 84,
                            "y2": 44,
                            "title": "Mandibular Right"
                          }),
                        );
                      },
                      text: 'Mandibular Right',
                    ),
                    MButton(
                      onPressed: () {
                        // final state =
                        //     Provider.of<HuckabaState>(context, listen: false);
                        // state.reset();
                        Navigator.push(
                          context,
                          hucabaAnalPageRouteBuilder(context, {
                            "x1": 74,
                            "x2": 74,
                            "y2": 34,
                            "title": "Mandibular Left"
                          }),
                        );
                      },
                      text: 'Mandibular Left',
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
