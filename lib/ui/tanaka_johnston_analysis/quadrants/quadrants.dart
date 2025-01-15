import 'package:flutter/material.dart';

import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/summary.dart';

class TanakaJohnstonQuads extends StatefulWidget {
  final String type; // Mandibular or Maxillary
  final Map tanakaData;

  const TanakaJohnstonQuads({super.key, required this.type, required this.tanakaData});

  @override
  _TanakaJohnstonQuadsState createState() => _TanakaJohnstonQuadsState();
}

class _TanakaJohnstonQuadsState extends State<TanakaJohnstonQuads> {
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
            tanakaData: widget.tanakaData,
          ),
          Page2(
            type: widget.type,
            pageController: _pageController,
          ),
          Page3(
            type: widget.type,
            pageController: _pageController,
            tanakaData: widget.tanakaData,
          ),
          SummaryPage(
            type: widget.type,
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}