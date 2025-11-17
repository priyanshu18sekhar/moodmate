import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodmate/main.dart';

void main() {
  testWidgets('MoodMate app loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MoodMateApp());
    
    // Verify that the app initializes
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
