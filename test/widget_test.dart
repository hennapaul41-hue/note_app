import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/main.dart';
import 'package:note_app/routes/app_routes.dart';

void main() {
  testWidgets('App starts and shows Welcome page', (WidgetTester tester) async {
    // 🚀 Load app with initialRoute = welcome
    await tester.pumpWidget(const MyApp(initialRoute: AppRoutes.welcome));

    // ⏳ wait for UI to fully build
    await tester.pumpAndSettle();

    // ✅ Check Welcome Page UI
    expect(find.text('My Notebook'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('Navigate from Welcome to Registration', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp(initialRoute: AppRoutes.welcome));
    await tester.pumpAndSettle();

    // 👆 Tap Continue button
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // ✅ Now Registration page should appear
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('SIGN UP'), findsOneWidget);
  });
}
