import 'package:flutter/material.dart';
import 'package:ispacalise/ui/radiographic_mixed_analysis/quadrants/quadrants.dart';
import '../ui/huckaba_analysis/index.dart';
import '../ui/huckaba_analysis/quadrants/quadrants.dart';
import '../ui/moyers_analysis/index.dart';
import '../ui/moyers_analysis/quadrants/quadrants.dart';
import '../ui/radiographic_mixed_analysis/index.dart';
import '../ui/tanaka_johnston_analysis/index.dart';
import '../ui/tanaka_johnston_analysis/quadrants/quadrants.dart';


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


/// slide transition for the radiographic mixed dentition page
PageRouteBuilder radiographicMixedDentitionPageRouteBuilder(BuildContext context) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const RadiographicMixedDentitionAnalysisPage(),
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

PageRouteBuilder radiographicMixedDentitionAnalPageRouteBuilder(BuildContext context, type, radiographicData) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RadiographicMixedDentitionQuads(type: type, radiographyData: radiographicData),
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

/// slide transition for the radiographic mixed dentition page
PageRouteBuilder moyersAnalysisPageRouteBuilder(BuildContext context) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MoyersAnalysisPage(),
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

PageRouteBuilder moyersAnalysisAnalPageRouteBuilder(BuildContext context, type, radiographicData) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MoyersQuads(type: type, radiographyData: radiographicData),
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
