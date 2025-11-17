import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// Entry point of the Daily Mood Tracker app.
void main() {
  runApp(const DailyMoodTrackerApp());
}

/// Root widget for the app.
class DailyMoodTrackerApp extends StatelessWidget {
  const DailyMoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}