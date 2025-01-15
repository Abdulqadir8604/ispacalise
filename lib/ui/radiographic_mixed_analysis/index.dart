import 'package:flutter/material.dart';
import 'package:ispacalise/provider/RadiographicState.dart';
import 'package:ispacalise/util/slide_transition.dart';
import 'package:provider/provider.dart';

import '../../util/mbutton.dart';

class RadiographicMixedDentitionAnalysisPage extends StatefulWidget {
  const RadiographicMixedDentitionAnalysisPage({super.key});

  @override
  State<RadiographicMixedDentitionAnalysisPage> createState() =>
      _RadiographicMixedDentitionAnalysisPageState();
}

class _RadiographicMixedDentitionAnalysisPageState
    extends State<RadiographicMixedDentitionAnalysisPage> {
  Widget build(BuildContext context) {
    @override
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text(
          'Radiographic Analysis',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final state = Provider.of<RadiographicState>(context, listen: false);
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
                  "To predict space discrepancy with respect to unerupted permanent canines and premolars by a radiographic method.",
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
                  "OPG\nStudy model\nScale\nDivider",
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
                        // final state = Provider.of<RadiographicState>(context,
                        //     listen: false);
                        // state.reset();
                        Navigator.push(
                          context,
                          radiographicMixedDentitionAnalPageRouteBuilder(
                              context, "Mandibular", {
                            // 1st page
                            "1-1": 41,
                            "1-2": 42,
                            "1-3": 31,
                            "1-4": 32,
                            // 2nd page
                            "2-1": 83,
                            "2-2": 84,
                            "2-3": 85,
                            "2-4": 73,
                            "2-5": 74,
                            "2-6": 75,
                            // 3rd page
                            "3-1": 43,
                            "3-2": 44,
                            "3-3": 45,
                            "3-4": 33,
                            "3-5": 34,
                            "3-6": 35,
                            // 4th page
                            "4-1": 83,
                            "4-2": 84,
                            "4-3": 85,
                            "4-4": 73,
                            "4-5": 74,
                            "4-6": 75,
                            // 5th page
                            "5-1-1": 85,
                            "5-1-2": 83,
                            "5-2": 83,
                            "5-3": 73,
                            "5-4-1": 73,
                            "5-4-2": 75,
                          }),
                        );
                      },
                      text: 'Mandibular',
                    ),
                    MButton(
                      height: 100,
                      width: 170,
                      onPressed: () {
                        // final state = Provider.of<RadiographicState>(context,
                        //     listen: false);
                        // state.reset();
                        Navigator.push(
                          context,
                          radiographicMixedDentitionAnalPageRouteBuilder(
                              context, "Maxillary", {
                            // 1st page
                            "1-1": 11,
                            "1-2": 12,
                            "1-3": 21,
                            "1-4": 22,
                            // 2nd page
                            "2-1": 53,
                            "2-2": 54,
                            "2-3": 55,
                            "2-4": 63,
                            "2-5": 63,
                            "2-6": 63,
                            // 3rd page
                            "3-1": 13,
                            "3-2": 14,
                            "3-3": 15,
                            "3-4": 23,
                            "3-5": 24,
                            "3-6": 25,
                            // 4th page
                            "4-1": 53,
                            "4-2": 54,
                            "4-3": 55,
                            "4-4": 63,
                            "4-5": 64,
                            "4-6": 65,
                            // 5th page
                            "5-1-1": 55,
                            "5-1-2": 53,
                            "5-2": 53,
                            "5-3": 63,
                            "5-4-1": 63,
                            "5-4-2": 65,
                          }),
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
