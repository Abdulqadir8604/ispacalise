import 'package:flutter/material.dart';
import 'package:ispacalise/ui/MButton.dart';

import 'quadrants/huckaba_quadrants.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: const Text('Huckaba Analysis',
            style: TextStyle(color: Colors.black, fontSize: 30)),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Introduction: ",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                const Text(
                  "To predict the space discrepancy with regards to unerupted first premolars while planning a unilateral space maintainer with the help of IOPA.",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 20),
                Text("Armanentarium: ",
                    style: TextStyle(
                        fontSize: 30,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                Text(
                  "Study model\nScale\nDivider\nIOPA of the quadrant in which space maintainer(unilateral) is planned",
                  style: TextStyle(fontSize: 25, color: colorScheme.onSurface),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 3,
                  padding: const EdgeInsets.all(8),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    MButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HuckabaQuads(
                              huckabaData: {"x1": 54, "x2": 54, "y2": 14, "title": "Maxillary Right"},
                            ),
                          ),
                        );
                      },
                      text: 'Maxillary Right Quadrant',
                    ),
                    MButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HuckabaQuads(
                              huckabaData: {"x1": 64, "x2": 64, "y2": 24, "title": "Maxillary Left"},
                            ),
                          ),
                        );
                      },
                      text: 'Maxillary Left Quadrant',
                    ),
                    MButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HuckabaQuads(
                              huckabaData: {"x1": 84, "x2": 84, "y2": 44, "title": "Mandibular Right"},
                            ),
                          ),
                        );
                      },
                      text: 'Mandibular Right Quadrant',
                    ),
                    MButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HuckabaQuads(
                              huckabaData: {"x1": 74, "x2": 74, "y2": 44, "title": "Mandibular Left"},
                            ),
                          ),
                        );
                      },
                      text: 'Mandibular Left Quadrant',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
