import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/screens/commercial_screen.dart';

void main() {
  testWidgets('CommercialScreen app bar test', (WidgetTester tester) async {
    await tester.pumpWidget(CommercialScreen(data: []));
    
    expect(find.byType(CustomAppBar), findsOneWidget);
  });

  testWidgets('CommercialScreen texts test', (WidgetTester tester) async {
    await tester.pumpWidget(CommercialScreen(data: []));

    expect(find.text('Hotels'), findsOneWidget);
    expect(find.text('Resturants'), findsOneWidget);
    expect(find.text('Shops'), findsOneWidget);
  });

  group('CommercialScreen Unit Tests', () {
    test('filterPlacesBySubtype returns correct list for a given subtype', () {
      final testData = [
        {'subtype': 'hotel', 'name': 'Hotel A'},
        {'subtype': 'hotel', 'name': 'Hotel B'},
        {'subtype': 'restaurant', 'name': 'Restaurant A'},
        {'subtype': 'shop', 'name': 'Shop A'},
      ];

      final commercialScreen = CommercialScreen(data: testData);
      final hotelsList = commercialScreen.filterPlacesBySubtype('hotel');
      final restaurantsList =
          commercialScreen.filterPlacesBySubtype('restaurant');
      final shopsList = commercialScreen.filterPlacesBySubtype('shop');

      expect(hotelsList.length, 2);
      expect(restaurantsList.length, 1);
      expect(shopsList.length, 1);
    });

    test(
        'filterPlacesBySubtype returns empty list if no places match the subtype',
        () {
      final testData = [
        {'subtype': 'hotel', 'name': 'Hotel A'},
        {'subtype': 'hotel', 'name': 'Hotel B'},
        {'subtype': 'restaurant', 'name': 'Restaurant A'},
        {'subtype': 'shop', 'name': 'Shop A'},
      ];

      final commercialScreen = CommercialScreen(data: testData);
      final parksList = commercialScreen.filterPlacesBySubtype('park');

      expect(parksList.isEmpty, true);
    });

    test('Widget displays appropriate subtypes', () {
      final testData = [
        {'subtype': 'hotel', 'name': 'Hotel A'},
        {'subtype': 'hotel', 'name': 'Hotel B'},
        {'subtype': 'restaurant', 'name': 'Restaurant A'},
        {'subtype': 'shop', 'name': 'Shop A'},
      ];

      final commercialScreen = CommercialScreen(data: testData);

      expect(commercialScreen.filterPlacesBySubtype('hotel'), isNotEmpty);
      expect(commercialScreen.filterPlacesBySubtype('restaurant'), isNotEmpty);
      expect(commercialScreen.filterPlacesBySubtype('shop'), isNotEmpty);
    });

    test('Widget displays no subtypes when no data is provided', () {
      final commercialScreen = CommercialScreen(data: []);

      expect(commercialScreen.filterPlacesBySubtype('hotel'), isEmpty);
      expect(commercialScreen.filterPlacesBySubtype('restaurant'), isEmpty);
      expect(commercialScreen.filterPlacesBySubtype('shop'), isEmpty);
    });

    test('Widget displays no subtypes when data does not match subtype', () {
      final testData = [
        {'subtype': 'park', 'name': 'Park A'},
        {'subtype': 'park', 'name': 'Park B'},
        {'subtype': 'park', 'name': 'Park C'},
      ];

      final commercialScreen = CommercialScreen(data: testData);

      expect(commercialScreen.filterPlacesBySubtype('hotel'), isEmpty);
      expect(commercialScreen.filterPlacesBySubtype('restaurant'), isEmpty);
      expect(commercialScreen.filterPlacesBySubtype('shop'), isEmpty);
    });
  });
}
