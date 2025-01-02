import 'package:flutter/material.dart';
import 'package:ispacalise/util/slide_transition.dart';

import '../../util/mbutton.dart';

class RadiographicMixedDentitionAnalysisPage extends StatefulWidget {
  const RadiographicMixedDentitionAnalysisPage({super.key});

  @override
  State<RadiographicMixedDentitionAnalysisPage> createState() => _RadiographicMixedDentitionAnalysisPageState();
}

class _RadiographicMixedDentitionAnalysisPageState extends State<RadiographicMixedDentitionAnalysisPage> {
  Widget build(BuildContext context) {
    @override
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text(
          'RMD Analysis',
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
                Text("Under Construction",
                    style: TextStyle(
                        fontSize:
                        Theme.of(context).textTheme.titleLarge?.fontSize,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                    )),
                // GridView.count(
                //   crossAxisCount: 2,
                //   shrinkWrap: true,
                //   childAspectRatio: 2,
                //   padding: const EdgeInsets.all(8),
                //   mainAxisSpacing: 8,
                //   physics: const NeverScrollableScrollPhysics(),
                //   crossAxisSpacing: 8,
                //   children: [
                //     MButton(
                //       height: 100,
                //       width: 170,
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           radiographicMixedDentitionAnalPageRouteBuilder(context, {
                //             // 1st page
                //             "1-1": 41,
                //             "1-2": 42,
                //             "1-3": 31,
                //             "1-4": 32,
                //             // 2nd page
                //             "2-1-1": 55,
                //             "2-1-2": 53,
                //             "2-2": 53,
                //             "2-3": 63,
                //             "2-4-1": 63,
                //             "2-4-2": 65,
                //           }),
                //         );
                //       },
                //       text: 'Mandibular',
                //     ),
                //     MButton(
                //       height: 100,
                //       width: 170,
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           radiographicMixedDentitionAnalPageRouteBuilder(context, {
                //             // 1st page
                //             "1-1": 41,
                //             "1-2": 42,
                //             "1-3": 31,
                //             "1-4": 32,
                //             // 2nd page
                //             "2-1-1": 55,
                //             "2-1-2": 53,
                //             "2-2": 53,
                //             "2-3": 63,
                //             "2-4-1": 63,
                //             "2-4-2": 65,
                //           }),
                //         );
                //       },
                //       text: 'Maxillary',
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
