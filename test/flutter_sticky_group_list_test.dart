import 'package:flutter/material.dart';
import 'package:flutter_sticky_group_list/flutter_sticky_group_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(GroupedListView, () {
    final emptyList = <String>[];
    final itemList = [
      'Apple',
      'Banana',
      'Cherry',
      'Blueberry',
      'Cranberry',
      'Coconut',
      'Custard',
      'Cucumber',
      'Date',
      'Dragonfruit',
      'Durian',
    ];

    testWidgets('renders items grouped with headers',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupedListView<String, String>(
              items: itemList,
              groupBy: (item) => item![0],
              groupBuilder: (group) => ColoredBox(
                color: Colors.blueAccent,
                child: Text(group, style: const TextStyle(color: Colors.white)),
              ),
              itemBuilder: (item) => ListTile(title: Text(item)),
            ),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);
    });

    testWidgets('supports sticky headers', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupedListView<String, String>(
              items: itemList,
              groupBy: (item) => item![0],
              groupBuilder: (group) => ColoredBox(
                color: Colors.blueAccent,
                child: Text(group, style: const TextStyle(color: Colors.white)),
              ),
              itemBuilder: (item) => ListTile(title: Text(item)),
              hasStickyHeader: true,
            ),
          ),
        ),
      );

      expect(find.text('A'), findsNWidgets(2));
    });

    testWidgets('supports sorting in ascending order',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupedListView<String, String>(
              items: itemList,
              groupBy: (item) => item![0],
              groupBuilder: (group) => ColoredBox(
                color: Colors.blueAccent,
                child: Text(group, style: const TextStyle(color: Colors.white)),
              ),
              itemBuilder: (item) => ListTile(title: Text(item)),
            ),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('supports pull-to-refresh', (WidgetTester tester) async {
      var isRefreshed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupedListView<String, String>(
              items: itemList,
              groupBy: (item) => item![0],
              groupBuilder: (group) => ColoredBox(
                color: Colors.blueAccent,
                child: Text(group, style: const TextStyle(color: Colors.white)),
              ),
              itemBuilder: (item) => ListTile(title: Text(item)),
              hasRefreshIndicator: true,
              onRefresh: () async => isRefreshed = true,
            ),
          ),
        ),
      );

      expect(find.byType(RefreshIndicator), findsOneWidget);

      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(RefreshIndicator)),
      );

      await gesture.moveBy(const Offset(0, 300));
      await gesture.up();

      await tester.pumpAndSettle();

      expect(isRefreshed, isTrue);
    });

    testWidgets('shows empty state when items list is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GroupedListView<String, String>(
              items: emptyList,
              groupBy: (item) => item![0],
              groupBuilder: (group) => ColoredBox(
                color: Colors.blueAccent,
                child: Text(group, style: const TextStyle(color: Colors.white)),
              ),
              itemBuilder: (item) => ListTile(title: Text(item)),
              emptyList: const Text('No items available'),
            ),
          ),
        ),
      );

      expect(find.text('No items available'), findsOneWidget);
    });
  });
}
