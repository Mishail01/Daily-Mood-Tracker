// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import using the package name from pubspec.yaml (daily_mood_tracker)
import 'package:daily_mood_tracker/main.dart';

void main() {
  testWidgets('App smoke test - main screen appears',
      (WidgetTester tester) async {
    // Pump your app's root widget. Your app's class in main.dart is
    // DailyMoodTrackerApp (not MyApp).
    await tester.pumpWidget(const DailyMoodTrackerApp());
    await tester.pumpAndSettle();

    // Verify a widget that should exist on the HomeScreen.
    expect(find.text('How are you feeling today?'), findsOneWidget);

    // Also verify the app bar title is present.
    expect(find.text('Daily Mood Tracker'), findsOneWidget);
  });
}
