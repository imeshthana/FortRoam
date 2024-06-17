import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/components/app_bar1.dart';
import 'package:fort_roam/screens/about_us_screen.dart';

void main() {
  testWidgets('AboutUsScreen custom app bar test', (WidgetTester tester) async {
    await tester.pumpWidget((AboutUsScreen()));
    expect(find.byType(CustomAppBar), findsOneWidget);
  });

  testWidgets('AboutUsScreen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(AboutUsScreen());

    expect(find.text('About Us'), findsOneWidget);
  });

  testWidgets('AboutUsScreen vision section test', (WidgetTester tester) async {
    await tester.pumpWidget(AboutUsScreen());

    expect(find.text('Our Vision'), findsOneWidget);
  });

  testWidgets('AboutUsScreen mission section test',
      (WidgetTester tester) async {
    await tester.pumpWidget(AboutUsScreen());

    expect(find.text('Our Mission'), findsOneWidget);
  });

  testWidgets('AboutUsScreen contact section test',
      (WidgetTester tester) async {
    await tester.pumpWidget(AboutUsScreen());

    expect(find.text('Contact Us'), findsOneWidget);
  });

  testWidgets('AboutUsScreen developed by section test',
      (WidgetTester tester) async {
    await tester.pumpWidget(AboutUsScreen());

    expect(find.text('Developed By'), findsOneWidget);
  });

  testWidgets('AboutUsScreen contact details test',
      (WidgetTester tester) async {
    await tester.pumpWidget(AboutUsScreen());

    expect(find.byType(ContactDetailTile), findsWidgets);
  });
}
