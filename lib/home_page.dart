import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ispacalise/util/mAppBar.dart';
import 'util/mbutton.dart';
import 'util/slide_transition.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const mAppBar(
        title: 'iSpacalize',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MButton(
              height: 100,
              width: 250,
              onPressed: () {
                Navigator.push(
                  context,
                  moyersAnalysisPageRouteBuilder(context),
                );
              },
              text: 'Moyer\'s Analysis',
            ),
            const SizedBox(height: 20),
            MButton(
              height: 100,
              width: 250,
              onPressed: () {
                Navigator.push(
                  context,
                  radiographicMixedDentitionPageRouteBuilder(context),
                );
              },
              text: 'Radiographic Mixed\nDentition Analysis',
            ),
            const SizedBox(height: 20),
            MButton(
              height: 100,
              width: 250,
              onPressed: () {
                Navigator.push(
                  context,
                  tanakaJohnstonPageRouteBuilder(context),
                );
              },
              text: 'Tanaka & Johnston\nAnalysis',
            ),
            const SizedBox(height: 20),
            MButton(
              height: 100,
              width: 250,
              onPressed: () {
                Navigator.push(
                  context,
                  hucabaPageRouteBuilder(context),
                );
              },
              text: 'Hucaba Analysis',
            ),
          ],
        ),
      ),
    );
  }
}