import 'package:flutter/material.dart';
import 'package:ispacalise/ui/MButton.dart';

import 'quadrants/mandibular_left.dart';
import 'quadrants/mandibular_right.dart';
import 'quadrants/maxillary_left.dart';
import 'quadrants/maxillary_right.dart';

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
        backgroundColor: Colors.white,
        title: const Text('Huckaba Analysis',
            style: TextStyle(color: Colors.black)),
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
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                const Text(
                  "To predict the space discrepancy with regards to unerupted first premolars while planning a unilateral space maintainer with the help of IOPA.",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                Text("Armanentarium: ",
                    style: TextStyle(
                        fontSize: 40,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                Text(
                  "Study model\nScale\nDivider\nIOPA of the quadrant in which space maintainer(unilateral) is planned",
                  style: TextStyle(fontSize: 30, color: colorScheme.onSurface),
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
                            builder: (context) => const MaxillaryRightPage(),
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
                            builder: (context) => const MaxillaryLeftPage(),
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
                            builder: (context) => const MandibularRightPage(),
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
                            builder: (context) => const MandibularLeftPage(),
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
