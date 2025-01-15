import 'package:flutter/material.dart';
import 'package:ispacalise/util/slide_transition.dart';

import '../../util/mbutton.dart';

class MoyersAnalysisPage extends StatefulWidget {
  const MoyersAnalysisPage({super.key});

  @override
  State<MoyersAnalysisPage> createState() =>
      _MoyersAnalysisPageState();
}

class _MoyersAnalysisPageState
    extends State<MoyersAnalysisPage> {
  Widget build(BuildContext context) {
    @override
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text(
          'Moyer\'s Analysis',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          ),
        ),
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
                  "To predict the space discrepancy with respect to the eruption of permanent canines an premolars with the help of erupted mandibular incisors and the Moyer’s prediction chart.",
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
                  "Study model\nDivider\nScale",
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                      fontStyle: FontStyle.italic,
                      color: colorScheme.onSurface),
                ),
                const SizedBox(height: 20),
                Text("Chart pending",
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    )),
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
                        Navigator.push(
                          context,
                          moyersAnalysisAnalPageRouteBuilder(
                              context, "Mandibular", {
                            // 1st page
                            "1-1": 41,
                            "1-2": 42,
                            "1-3": 31,
                            "1-4": 32,
                            // 2nd page
                            "2-1-1": 85,
                            "2-1-2": 83,
                            "2-2": 83,
                            "2-3": 73,
                            "2-4-1": 73,
                            "2-4-2": 75,
                          }),
                        );
                      },
                      text: 'Mandibular',
                    ),
                    MButton(
                      height: 100,
                      width: 170,
                      onPressed: () {
                        Navigator.push(
                          context,
                          moyersAnalysisAnalPageRouteBuilder(
                              context, "Maxillary", {
                            // 1st page
                            "1-1": 41,
                            "1-2": 42,
                            "1-3": 31,
                            "1-4": 32,
                            // 2nd page
                            "2-1-1": 55,
                            "2-1-2": 53,
                            "2-2": 53,
                            "2-3": 63,
                            "2-4-1": 63,
                            "2-4-2": 65,
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
