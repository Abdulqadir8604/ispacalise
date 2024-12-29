import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ispacalise/ui/MButton.dart';

import 'hackuba/huckaba_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('iSpacalise', style: TextStyle(color: Colors.black)),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HuckabaAnalysisPage(),
                  ),
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
