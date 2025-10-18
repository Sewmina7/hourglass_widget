// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with widgets and test the complete user experience.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:hourglass_widget/hourglass_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Hourglass widget integration test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Hourglass(
            fillAmount: 0.5,
            width: 100,
            height: 150,
          ),
        ),
      ),
    );

    // Verify that the hourglass widget is rendered
    expect(find.byType(Hourglass), findsOneWidget);
    
    // Verify that the hourglass has the correct fill amount
    final hourglassWidget = tester.widget<Hourglass>(find.byType(Hourglass));
    expect(hourglassWidget.fillAmount, equals(0.5));
  });
}
