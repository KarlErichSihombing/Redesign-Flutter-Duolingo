import 'package:flutter/material.dart';
import 'screens/home_screens.dart';

void main() {
  runApp(const DuolingoApp());
}

class DuolingoApp extends StatelessWidget {
  const DuolingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duolingo Redesign',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}