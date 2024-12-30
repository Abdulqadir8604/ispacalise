import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ispacalise/ui/mbutton.dart';

import 'hackuba/huckaba_page.dart';
import 'service/slide_transition.dart';

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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MButton(
              height: 50,
              width: 200,
              onPressed: () {
                Navigator.push(
                  context,
                  huckabaPageRouteBuilder(context),
                );
              },
              text: 'Huckaba Analysis',
            ),
          ],
        ),
      ),
    );
  }
}
