import 'dart:developer';

import 'package:flutter/material.dart';
import 'util/mbutton.dart';
import 'util/slide_transition.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        centerTitle: true,
        title: Text(
          'iSpacalise',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
          ),
        ),
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