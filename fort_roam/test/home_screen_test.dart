import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/components/items_list.dart';
import 'package:fort_roam/components/sections_row.dart';
import 'package:fort_roam/screens/galle_fort_screen.dart';
import 'package:fort_roam/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));

    expect(find.byType(CustomScrollView), findsOneWidget);
  });

  testWidgets('HomeScreen suggestions subtitle test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));

    expect(find.text('Suggestions'), findsOneWidget);
});

  testWidgets('HomeScreen read more button test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));

    expect(find.text('Read More'), findsOneWidget);
  });

  testWidgets('HomeScreen app bar test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));

    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('HomeScreen Galle Fort text test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));

    expect(find.text('Galle Fort'), findsOneWidget);
  });

  testWidgets('HomeScreen welcome text test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));

    expect(find.text('Welcome to,'), findsOneWidget);
  });

  testWidgets('HomeScreen sections row widget test', (WidgetTester tester) async {
  await tester.pumpWidget(HomeScreen(data: []));

  expect(find.byType(SectionsRow), findsOneWidget);
});

  testWidgets('HomeScreen items list widget test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));

    expect(find.byType(ItemsList), findsOneWidget);
  });

  testWidgets('HomeScreen read more button tap test', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen(data: []));
    await tester.tap(find.text('Read More'));
    await tester.pump();

    expect(find.byType(GalleFortScreen), findsOneWidget);
  });

}


