import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/main.dart';

void main() {
  testWidgets('App starts and shows Welcome page', (WidgetTester tester) async {
    // 🚀 Load app
    await tester.pumpWidget(const MyApp());

    // ⏳ wait for UI to fully build
    await tester.pumpAndSettle();

    // ✅ Check Welcome Page UI
    expect(find.text('Welcome to My Notebook'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Navigate from Welcome to Login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // 👆 Tap Login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // ✅ Now Login page should appear
    expect(find.text('Login'), findsWidgets);
  });
}
