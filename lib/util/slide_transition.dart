import 'package:flutter/material.dart';
import 'package:ispacalise/ui/tanaka_johnston/index.dart';

import '../ui/huckaba/index.dart';
import '../ui/huckaba/quadrants/quadrants.dart';
import '../ui/tanaka_johnston/quadrants/quadrants.dart';


/// slide transition for the hucaba page
PageRouteBuilder hucabaPageRouteBuilder(BuildContext context) {
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

PageRouteBuilder hucabaAnalPageRouteBuilder(BuildContext context, hucabaData) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HuckabaQuads(hucabaData: hucabaData),
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



/// slide transition for the tanaka johnston page
PageRouteBuilder tanakaJohnstonPageRouteBuilder(BuildContext context) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const TanakaJohnstonAnalysisPage(),
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

PageRouteBuilder tanakaJohnstonAnalPageRouteBuilder(BuildContext context, type, tanakaData) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => TanakaJohnstonQuads(type: type, tanakaData: tanakaData),
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
