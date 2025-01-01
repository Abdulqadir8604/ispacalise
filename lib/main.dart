import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ispacalise/home_page.dart';

import 'provider/HuckabaState.dart';
import 'provider/TanakaJohnstonState.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TanakaJohnstonState()),
        ChangeNotifierProvider(create: (_) => HuckabaState()),
      ],
      child: MaterialApp(
        title: 'iSpacalise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
