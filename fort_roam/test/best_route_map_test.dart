import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/screens/best_route_map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
testWidgets('Check if CircularProgressIndicator is shown before location data is fetched', (WidgetTester tester) async {
  await tester.pumpWidget(BestRouteMapScreen(data: []));

  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});

testWidgets('Check if AppBar is present', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: BestRouteMapScreen(data: [])));
  await tester.pump(); 

  expect(find.byType(AppBar), findsOneWidget);
});

testWidgets('Check if info window is shown on marker tap', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: BestRouteMapScreen(data: [])));
  await tester.pump(); 

  await tester.tap(find.byType(Marker));

  expect(find.byType(CustomInfoWindow), findsOneWidget);
});

testWidgets('Check if FloatingActionButton is present', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: BestRouteMapScreen(data: [])));
  await tester.pump(); 

  expect(find.byType(FloatingActionButton), findsOneWidget);
});

testWidgets('Check if markers are added to the map', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: BestRouteMapScreen(data: [])));
  await tester.pump(); 

  expect(find.byType(Marker), findsOneWidget);
});

testWidgets('Check if GoogleMap is initialized', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: BestRouteMapScreen(data: [])));
  await tester.pump();

  expect(find.byType(GoogleMap), findsOneWidget);
});



}


