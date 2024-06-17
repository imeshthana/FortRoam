import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fort_roam/screens/galle_fort_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:fort_roam/screens/galle_fort_screen.dart';

void main() {
  group('GalleFortScreen Widget Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GalleFortScreen(
          imageHeroTag: UniqueKey(),
          titleHeroTag: UniqueKey(),
        ),
      ));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Hero), findsNWidgets(2));
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Galle Fort'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });

  group('GalleFortScreen Unit Tests', () {
    test('Floating action button onPressed callback is called', () {
      final mockContext = MockBuildContext();
      final galleFortScreen = GalleFortScreen(
        imageHeroTag: UniqueKey(),
        titleHeroTag: UniqueKey(),
      );
      galleFortScreen.build(mockContext);

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.volume_up), findsOneWidget);

      final floatingActionButton = find.byType(FloatingActionButton);
      expect(floatingActionButton, findsOneWidget);
      (floatingActionButton.evaluate().single.widget as FloatingActionButton)
          .onPressed!();

    });

    test('Widget displays correct description text', () {
      final mockContext = MockBuildContext();
      final galleFortScreen = GalleFortScreen(
        imageHeroTag: UniqueKey(),
        titleHeroTag: UniqueKey(),
      );
      final widget = galleFortScreen.build(mockContext) as Scaffold;
      final container = widget.body as Container;
      final singleChildScrollView = container.child as SingleChildScrollView;
      final column = singleChildScrollView.child as Container;
      final children = column.child as Column;
      final descriptionContainer = children.children[5] as Container;
      final descriptionText = descriptionContainer.child as Text;

      expect(
        descriptionText.data,
        'Galle Fort is a historic fortified city located in the southwestern part of Sri Lanka, in the city of Galle. Originally built by the Portuguese in the 16th century and later extensively fortified by the Dutch in the 17th century, Galle Fort stands as a UNESCO World Heritage Site and is a prominent example of well-preserved colonial architecture.',
      );
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
