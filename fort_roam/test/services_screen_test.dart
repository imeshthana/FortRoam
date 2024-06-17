import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/screens/services_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:fort_roam/screens/services_screen.dart';

void main() {
  group('ServicesScreen Widget Tests', () {
    testWidgets('ServicesScreen app bar test', (WidgetTester tester) async {
      await tester.pumpWidget(ServicesScreen(data: []));

      expect(find.byType(CustomAppBar), findsOneWidget);
    });

    testWidgets('ServicesScreen texts test', (WidgetTester tester) async {
      await tester.pumpWidget(ServicesScreen(data: []));

      expect(find.text('Banks'), findsOneWidget);
      expect(find.text('Schools'), findsOneWidget);
      expect(find.text('Parking'), findsOneWidget);
      expect(find.text('Taxies'), findsOneWidget);
      expect(find.text('Others'), findsOneWidget);
    });

    testWidgets('Widget displays items for each subtype',
        (WidgetTester tester) async {
      final testData = [
        {'subtype': 'bank', 'name': 'Bank A'},
        {'subtype': 'school', 'name': 'School A'},
        {'subtype': 'parking', 'name': 'Parking A'},
        {'subtype': 'taxi', 'name': 'Taxi A'},
        {'subtype': 'police', 'name': 'Police A'},
        {'subtype': 'post', 'name': 'Post A'},
      ];

      await tester.pumpWidget(MaterialApp(home: ServicesScreen(data: testData)));

      expect(find.text('Bank A'), findsOneWidget);
      expect(find.text('School A'), findsOneWidget);
      expect(find.text('Parking A'), findsOneWidget);
      expect(find.text('Taxi A'), findsOneWidget);
      expect(find.text('Police A'), findsOneWidget);
      expect(find.text('Post A'), findsOneWidget);
    });
  });

  group('ServicesScreen Unit Tests', () {
    test('filterPlacesBySubtype returns correct list for a given subtype', () {
      final testData = [
        {'subtype': 'bank', 'name': 'Bank A'},
        {'subtype': 'school', 'name': 'School A'},
        {'subtype': 'parking', 'name': 'Parking A'},
        {'subtype': 'taxi', 'name': 'Taxi A'},
        {'subtype': 'police', 'name': 'Police A'},
        {'subtype': 'post', 'name': 'Post A'},
      ];

      final servicesScreen = ServicesScreen(data: testData);
      final banksList = servicesScreen.filterPlacesBySubtype('bank');
      final schoolsList = servicesScreen.filterPlacesBySubtype('school');
      final parkingList = servicesScreen.filterPlacesBySubtype('parking');
      final taxiList = servicesScreen.filterPlacesBySubtype('taxi');

      expect(banksList.length, 1);
      expect(schoolsList.length, 1);
      expect(parkingList.length, 1);
      expect(taxiList.length, 1);
    });

    test('filterOtherPlacesBySubtype returns correct list for other subtypes',
        () {
      final testData = [
        {'subtype': 'police', 'name': 'Police A'},
        {'subtype': 'post', 'name': 'Post A'},
      ];

      final servicesScreen = ServicesScreen(data: testData);
      final otherPlacesList = servicesScreen.filterOtherPlacesBySubtype();

      expect(otherPlacesList.length, 2);
    });
  });
}
