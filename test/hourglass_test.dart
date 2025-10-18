import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hourglass_widget/hourglass_widget.dart';

void main() {
  group('Hourglass Widget Tests', () {
    testWidgets('Hourglass widget renders correctly', (WidgetTester tester) async {
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

      expect(find.byType(Hourglass), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('Hourglass widget with custom colors renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Hourglass(
              fillAmount: 0.75,
              width: 120,
              height: 180,
              colors: const [Colors.purple, Colors.pink],
              colorStops: const [0.0, 1.0],
            ),
          ),
        ),
      );

      expect(find.byType(Hourglass), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('Hourglass widget respects fillAmount parameter', (WidgetTester tester) async {
      const fillAmount = 0.25;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Hourglass(
              fillAmount: fillAmount,
              width: 100,
              height: 150,
            ),
          ),
        ),
      );

      final hourglassWidget = tester.widget<Hourglass>(find.byType(Hourglass));
      expect(hourglassWidget.fillAmount, equals(fillAmount));
    });

    testWidgets('Hourglass widget respects size parameters', (WidgetTester tester) async {
      const width = 200.0;
      const height = 300.0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Hourglass(
              fillAmount: 0.5,
              width: width,
              height: height,
            ),
          ),
        ),
      );

      final hourglassWidget = tester.widget<Hourglass>(find.byType(Hourglass));
      expect(hourglassWidget.width, equals(width));
      expect(hourglassWidget.height, equals(height));
    });
  });
}
