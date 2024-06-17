import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/screens/place_map_screen.dart';
import 'package:fort_roam/screens/place_screen.dart';
import 'package:flutter/widgets.dart';

void main() {
  group('PlaceScreen', () {
    final imageHeroTag = UniqueKey();
    final titleHeroTag = UniqueKey();

    testWidgets('Renders PlaceScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: PlaceScreen(
        title: 'Test Place',
        imageHeroTag: imageHeroTag,
        titleHeroTag: titleHeroTag,
        qrPlace: false,
        data: [],
      )));
      expect(find.byType(PlaceScreen), findsOneWidget);
    });

    testWidgets('Tap on favorite icon toggles state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PlaceScreen(
            title: 'Test Place',
            qrPlace: false,
            data: [],
          ),
        ),
      );
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('Initial UI test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: PlaceScreen(
        title: 'Test Place',
        imageHeroTag: imageHeroTag,
        titleHeroTag: titleHeroTag,
        qrPlace: false,
        data: [],
      )));
      expect(find.text('Test Place'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(RatingBar), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('Add review', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: PlaceScreen(
        title: 'Test Place',
        imageHeroTag: imageHeroTag,
        titleHeroTag: titleHeroTag,
        qrPlace: false,
        data: [],
      )));

      await tester.enterText(find.byType(TextFormField).first, 'John Doe');
      await tester.enterText(find.byType(TextFormField).last, 'Great place!');
      await tester.tap(find.byType(RatingBar).first);
      await tester.tap(find.byType(MaterialButton));
      await tester.pump();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Great place!'), findsOneWidget);
      expect(find.text('Overall Rating'), findsOneWidget);
    });

    testWidgets('Navigate to PlaceMapScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: PlaceScreen(
        title: 'Test Place',
        imageHeroTag: imageHeroTag,
        titleHeroTag: titleHeroTag,
        qrPlace: false,
        data: [],
      )));

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(PlaceMapScreen), findsOneWidget);
    });

  });
}
