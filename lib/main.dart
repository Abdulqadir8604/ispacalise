import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import
import 'package:google_fonts/google_fonts.dart';
import 'package:ispacalise/provider/MoyersState.dart';
import 'package:ispacalise/provider/RadiographicState.dart';
import 'package:provider/provider.dart';
import 'package:ispacalise/home_page.dart';

import 'provider/HuckabaState.dart';
import 'provider/TanakaJohnstonState.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  // Set system UI overlay style to make navigation bar transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  // Make navigation bar transparent on Android
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme(
      titleLarge: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      titleMedium: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      titleSmall: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      bodyLarge: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      bodyMedium: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      bodySmall: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      displayLarge: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      displayMedium: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      displaySmall: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      headlineLarge: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      headlineMedium: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      headlineSmall: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      labelLarge: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      labelMedium: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
      labelSmall: TextStyle(fontFamily: GoogleFonts.lexendDeca().fontFamily),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoyersState()),
        ChangeNotifierProvider(create: (_) => RadiographicState()),
        ChangeNotifierProvider(create: (_) => TanakaJohnstonState()),
        ChangeNotifierProvider(create: (_) => HuckabaState()),
      ],
      child: MaterialApp(
        title: 'iSpacalize',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00BE64)),
          useMaterial3: true,
          textTheme: textTheme,
        ),
        debugShowMaterialGrid: false,
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00BE64), brightness: Brightness.dark),
          useMaterial3: true,
          textTheme: textTheme,
        ),
        // only allow portrait mode
        home: const HomePage(),
      ),
    );
  }
}
