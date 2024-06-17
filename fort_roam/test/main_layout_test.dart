import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/screens/main_layout.dart';
import 'package:mockito/mockito.dart';
import 'package:fort_roam/screens/main_layout.dart';

void main() {
  group('MainLayout Widget Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      final List<Map<String, dynamic>> mockData = [];
      await tester.pumpWidget(MaterialApp(
        home: MainLayout(data: mockData),
      ));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(BottomAppBar), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        'Widget navigates to correct page when bottom navigation item is tapped',
        (WidgetTester tester) async {
        final List<Map<String, dynamic>> mockData = [];
        await tester.pumpWidget(MaterialApp(
          home: MainLayout(data: mockData),
        ));

        // Tap the second bottom navigation item
        await tester.tap(find.text('Favorites'));
        await tester.pump();

        expect(find.text('Favorites'), findsOneWidget);
      });
    });

  // group('MainLayout Unit Tests', () {
  //   test('navigateToPage changes the current page', () {
  //     final List<Map<String, dynamic>> mockData = [];
  //     final mainLayout = MainLayout(data: mockData);
  //     final element = mainLayout.createState();
  //     element.initState();

  //     element.navigateToPage(1);

  //     expect(mainLayout.currentPage, 1);
  //   });

  //   test(
  //       'buildNavItem returns the correct navigation item when index is equal to currentPage',
  //       () {
  //     final List<Map<String, dynamic>> mockData = [];
  //     final mainLayout = MainLayout(data: mockData);

  //     final widget = mainLayout.buildNavItem(Icons.home_rounded, 'Home', 0);

  //     final icon = find.byType(Icon);
  //     final text = find.byType(Text);

  //     expect(icon, findsOneWidget);
  //     expect(text, findsOneWidget);
  //   });

  //   test(
  //       'buildNavItem returns the correct navigation item when index is not equal to currentPage',
  //       () {
  //     final List<Map<String, dynamic>> mockData = [];
  //     final mainLayout = MainLayout(data: mockData);

  //     mainLayout.currentPage = 1;
  //     final widget = mainLayout.buildNavItem(Icons.favorite, 'Favorites', 1);

  //     final icon = find.byType(Icon);
  //     final text = find.byType(Text);

  //     expect(icon, findsOneWidget);
  //     expect(text, findsNothing);
  //   });
  // });
}
