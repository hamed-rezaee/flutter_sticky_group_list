import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_group_list/flutter_sticky_group_list.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blueGrey,
        ),
        home: GroupedListViewExample(),
      );
}

class GroupedListViewExample extends StatefulWidget {
  const GroupedListViewExample({super.key});

  @override
  State<GroupedListViewExample> createState() => _GroupedListViewExampleState();
}

class _GroupedListViewExampleState extends State<GroupedListViewExample> {
  GroupedListViewOrder _order = GroupedListViewOrder.ascending;

  Future<void> _handleRefresh() async =>
      await Future.delayed(Duration(seconds: 2));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Grouped List View Example'),
          actions: [
            IconButton(
              icon: Icon(Icons.sort),
              onPressed: () => setState(() {
                _order = _order == GroupedListViewOrder.ascending
                    ? GroupedListViewOrder.descending
                    : GroupedListViewOrder.ascending;
              }),
            ),
          ],
        ),
        body: GroupedListView<SampleModel, String>(
          items: listItems,
          hasStickyHeader: true,
          hasRefreshIndicator: true,
          order: _order,
          onRefresh: _handleRefresh,
          groupBy: (item) => item!.group,
          groupBuilder: (group) => Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            color: Colors.blueGrey[100],
            child: Text(
              group,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (item) => ListTile(title: Text(item.item)),
        ),
      );
}

class SampleModel with EquatableMixin {
  const SampleModel(this.group, this.item);

  final String group;
  final String item;

  @override
  List<Object?> get props => [group, item];
}

final List<SampleModel> listItems = [
  SampleModel('A', 'Apple'),
  SampleModel('A', 'Apricot'),
  SampleModel('A', 'Avocado'),
  SampleModel('B', 'Banana'),
  SampleModel('B', 'Blackberry'),
  SampleModel('B', 'Blueberry'),
  SampleModel('C', 'Cherry'),
  SampleModel('C', 'Coconut'),
  SampleModel('C', 'Cranberry'),
  SampleModel('C', 'Cucumber'),
  SampleModel('D', 'Date'),
  SampleModel('D', 'Dragonfruit'),
  SampleModel('D', 'Durian'),
  SampleModel('G', 'Grape'),
  SampleModel('G', 'Guava'),
  SampleModel('K', 'Kiwi'),
  SampleModel('L', 'Lemon'),
  SampleModel('L', 'Lime'),
  SampleModel('M', 'Mango'),
  SampleModel('O', 'Orange'),
  SampleModel('P', 'Papaya'),
  SampleModel('P', 'Peach'),
  SampleModel('P', 'Pear'),
  SampleModel('P', 'Pineapple'),
  SampleModel('P', 'Plum'),
  SampleModel('P', 'Pomegranate'),
  SampleModel('R', 'Raspberry'),
  SampleModel('S', 'Strawberry'),
];
