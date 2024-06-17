import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/components/app_bar2.dart';
import 'package:fort_roam/components/items_grid.dart';
import 'package:fort_roam/screens/activity_screen.dart';

void main() {

  testWidgets('ActivityScreen app bar test', (WidgetTester tester) async {
  await tester.pumpWidget(ActivityScreen(data: []));

  expect(find.byType(CustomAppBar), findsOneWidget);
});

testWidgets('ActivityScreen items grid test', (WidgetTester tester) async {
  await tester.pumpWidget(ActivityScreen(data: []));

  expect(find.byType(ItemsGrid), findsOneWidget);
});

test('ActivityScreen filter places by subtype test', () {
  final List<Map<String, dynamic>> testData = [
    {'name': 'Place 1', 'subtype': 'activity'},
    {'name': 'Place 2', 'subtype': 'sightseeing'},
    {'name': 'Place 3', 'subtype': 'activity'},
  ];

  final activityScreen = ActivityScreen(data: testData);

  final filteredPlaces = activityScreen.filterPlacesBySubtype();

  expect(filteredPlaces.length, 2);
});

test('ActivityScreen empty filter places by subtype test', () {
  final List<Map<String, dynamic>> testData = [
    {'name': 'Place 1', 'subtype': 'sightseeing'},
    {'name': 'Place 2', 'subtype': 'shopping'},
  ];

  final activityScreen = ActivityScreen(data: testData);

  final filteredPlaces = activityScreen.filterPlacesBySubtype();

  expect(filteredPlaces.length, 0);
});

test('ActivityScreen non-empty filter places by subtype test', () {
  final List<Map<String, dynamic>> testData = [
    {'name': 'Place 1', 'subtype': 'activity'},
    {'name': 'Place 2', 'subtype': 'sightseeing'},
    {'name': 'Place 3', 'subtype': 'activity'},
  ];

  final activityScreen = ActivityScreen(data: testData);

  final filteredPlaces = activityScreen.filterPlacesBySubtype();

  expect(filteredPlaces.isNotEmpty, true);
});

testWidgets('ActivityScreen empty data subtitle test', (WidgetTester tester) async {
  await tester.pumpWidget(ActivityScreen(data: []));

  expect(find.text('Activities'), findsNothing);
});

testWidgets('ActivityScreen non-empty data subtitle test', (WidgetTester tester) async {
  await tester.pumpWidget(ActivityScreen(data: [{'name': 'Place 1', 'subtype': 'activity'}]));

  expect(find.text('Activities'), findsOneWidget);
});

testWidgets('ActivityScreen non-empty data items grid test', (WidgetTester tester) async {
  await tester.pumpWidget(ActivityScreen(data: [{'name': 'Place 1', 'subtype': 'activity'}]));

  expect(find.byType(ItemsGrid), findsOneWidget);
});


testWidgets('ActivityScreen empty data items grid test', (WidgetTester tester) async {
  await tester.pumpWidget(ActivityScreen(data: []));

  expect(find.byType(ItemsGrid), findsNothing);
});


}
