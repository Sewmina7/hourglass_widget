// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:hourglass_widget_example/main.dart';
import 'package:hourglass_widget/hourglass_widget.dart';

void main() {
  testWidgets('Verify Hourglass Widget Demo', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the demo app loads correctly.
    expect(
      find.text('Hourglass Widget Demo'),
      findsOneWidget,
    );
    
    // Verify that hourglass widgets are present
    expect(
      find.byType(Hourglass),
      findsWidgets,
    );
  });
}
