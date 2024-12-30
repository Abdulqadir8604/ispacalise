import 'package:flutter/material.dart';
import 'package:ispacalise/hackuba/quadrants/huckaba_quadrants.dart';

import '../hackuba/huckaba_page.dart';

PageRouteBuilder huckabaPageRouteBuilder(BuildContext context) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HuckabaAnalysisPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

PageRouteBuilder huckabaAnalPageRouteBuilder(BuildContext context, huckabaData) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HuckabaQuads(huckabaData: huckabaData),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}