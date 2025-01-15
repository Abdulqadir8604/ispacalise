import 'package:flutter/material.dart';

import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/summary1.dart';
import 'pages/summary2.dart';

class MoyersQuads extends StatefulWidget {
  final String type; // Mandibular or Maxillary
  final Map radiographyData;

  const MoyersQuads(
      {super.key, required this.type, required this.radiographyData});

  @override
  State<MoyersQuads> createState() =>
      _MoyerAnalysisQuads();
}

class _MoyerAnalysisQuads
    extends State<MoyersQuads> {
  final Map<String, String> formData = {};
  final PageController _pageController = PageController();

  void updateFormData(String key, String value) {
    setState(() {
      formData[key] = value;
    });
  }

  void navigateToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Page1(
            type: widget.type,
            pageController: _pageController,
            moyerData: widget.radiographyData,
          ),
          Summary1Page(
            type: widget.type,
            pageController: _pageController,
          ),
          Page2(
            type: widget.type,
            pageController: _pageController,
            moyerData: widget.radiographyData,
          ),
          Summary2Page(
            type: widget.type,
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}
