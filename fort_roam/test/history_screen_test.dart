import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/components/app_bar1.dart';
import 'package:mockito/mockito.dart';
import 'package:fort_roam/screens/history_screen.dart';
import 'dart:ui';

void main() {
  testWidgets('HistoryScreen app bar test', (WidgetTester tester) async {
    await tester.pumpWidget(HistoryScreen(data: []));

    expect(find.byType(CustomAppBar), findsOneWidget);
  });

  testWidgets('HistoryScreen texts test', (WidgetTester tester) async {
    await tester.pumpWidget(HistoryScreen(data: []));

    expect(find.text('Museusms'), findsOneWidget);
    expect(find.text('Bastions'), findsOneWidget);
    expect(find.text('Others'), findsOneWidget);
  });

  group('HistoryScreen Widget Tests', () {
    testWidgets('Widget displays items for each subtype',
        (WidgetTester tester) async {
      final testData = [
        {'subtype': 'museum', 'name': 'Museum A'},
        {'subtype': 'museum', 'name': 'Museum B'},
        {'subtype': 'bastion', 'name': 'Bastion A'},
        {'subtype': 'others', 'name': 'Other A'},
      ];

      await tester.pumpWidget(MaterialApp(home: HistoryScreen(data: testData)));

      expect(find.text('Museum A'), findsOneWidget);
      expect(find.text('Museum B'), findsOneWidget);
      expect(find.text('Bastion A'), findsOneWidget);
      expect(find.text('Other A'), findsOneWidget);
    });
  });

  group('HistoryScreen Unit Tests', () {
    test('filterPlacesBySubtype returns correct list for a given subtype', () {
      final testData = [
        {'subtype': 'museum', 'name': 'Museum A'},
        {'subtype': 'museum', 'name': 'Museum B'},
        {'subtype': 'bastion', 'name': 'Bastion A'},
        {'subtype': 'others', 'name': 'Other A'},
      ];

      final historyScreen = HistoryScreen(data: testData);
      final museumsList = historyScreen.filterPlacesBySubtype('museum');
      final bastionsList = historyScreen.filterPlacesBySubtype('bastion');
      final othersList = historyScreen.filterPlacesBySubtype('others');

      expect(museumsList.length, 2);
      expect(bastionsList.length, 1);
      expect(othersList.length, 1);
    });

    test(
        'filterPlacesBySubtype returns empty list if no places match the subtype',
        () {
      final testData = [
        {'subtype': 'museum', 'name': 'Museum A'},
        {'subtype': 'museum', 'name': 'Museum B'},
        {'subtype': 'bastion', 'name': 'Bastion A'},
        {'subtype': 'others', 'name': 'Other A'},
      ];

      final historyScreen = HistoryScreen(data: testData);
      final parksList = historyScreen.filterPlacesBySubtype('park');

      expect(parksList.isEmpty, true);
    });
  });
}
