import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/screens/favourites_screen.dart';
import 'package:fort_roam/screens/best_route_map_screen.dart';
import 'package:fort_roam/screens/custom_route_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';

void main() {
  group('FavouritesScreen', () {
    testWidgets('Renders FavouritesScreen', (WidgetTester tester) async {
      await tester.pumpWidget(FavouritesScreen(data: []));
      expect(find.byType(FavouritesScreen), findsOneWidget);
    });

    testWidgets('Initial UI test', (WidgetTester tester) async {
      await tester.pumpWidget(FavouritesScreen(data: []));
      expect(find.text('Best Route'), findsOneWidget);
      expect(find.text('Custom Route'), findsOneWidget);
      expect(find.text('Favourites'), findsOneWidget);
    });

    testWidgets('Tap on Best Route navigates', (WidgetTester tester) async {
      await tester.pumpWidget(FavouritesScreen(data: []));
      await tester.tap(find.text('Best Route'));
      await tester.pump();
      expect(find.byWidget(BestRouteMapScreen(data: [])), findsOneWidget);
    });

    testWidgets('Tap on Custom Route navigates', (WidgetTester tester) async {
      await tester.pumpWidget(FavouritesScreen(data: []));
      await tester.tap(find.text('Custom Route'));
      await tester.pump();
      expect(find.byWidget(CustomRouteMapScreen(data: [])), findsOneWidget);
    });

    testWidgets('Remove place from favourites', (WidgetTester tester) async {
      await tester.pumpWidget(FavouritesScreen(data: []));
      await tester.tap(find.byType(Dismissible));
      await tester.pump();
      expect(find.byType(Dismissible), findsNothing);
    });

    testWidgets('Navigate to place screen', (WidgetTester tester) async {
      await tester.pumpWidget(FavouritesScreen(data: []));
      await tester.tap(find.byElementType(GestureDetector));
      await tester.pump();
      expect(find.byWidget(PlaceScreen(title:'',data: [],qrPlace: true)), findsOneWidget);
    });
  });

}
