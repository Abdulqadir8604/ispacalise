import 'package:flutter/material.dart';
import 'package:ispacalise/ui/radiographic_mixed_dentition/quadrants/pages/summary1.dart';

import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/page4.dart';
import 'pages/page5.dart';
import 'pages/summary2.dart';

class RadiographicMixedDentitionQuads extends StatefulWidget {
  final String type; // Mandibular or Maxillary
  final Map radiographyData;

  const RadiographicMixedDentitionQuads(
      {super.key, required this.type, required this.radiographyData});

  @override
  _RadiographicMixedDentitionQuads createState() =>
      _RadiographicMixedDentitionQuads();
}

class _RadiographicMixedDentitionQuads
    extends State<RadiographicMixedDentitionQuads> {
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
            radioData: widget.radiographyData,
          ),
          Page2(
            type: widget.type,
            pageController: _pageController,
            radioData: widget.radiographyData,
          ),
          Page3(
            type: widget.type,
            pageController: _pageController,
            radioData: widget.radiographyData,
          ),
          Page4(
            type: widget.type,
            pageController: _pageController,
            radioData: widget.radiographyData,
          ),
          Summary1Page(
            type: widget.type,
            pageController: _pageController,
          ),
          Page5(
            type: widget.type,
            pageController: _pageController,
            radioData: widget.radiographyData,
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
