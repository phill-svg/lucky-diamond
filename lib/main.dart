import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pokie/home_screen.dart';
import 'pokie/pokie_screen.dart';

void main() {
  // On the website the lobby page is the homepage, so open on the reels.
  runApp(PokieApp(home: kIsWeb ? const PokieScreen() : const HomeScreen()));
}

class PokieApp extends StatelessWidget {
  const PokieApp({super.key, this.home = const HomeScreen()});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lucky Diamonds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC94A),
          brightness: Brightness.dark,
        ),
      ),
      home: home,
    );
  }
}
