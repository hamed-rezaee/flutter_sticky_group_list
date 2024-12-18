# GroupedListView for Flutter

`GroupedListView` is a powerful Flutter widget that allows you to display a grouped, scrollable list with additional features like sticky headers, sorting, pull-to-refresh, and load more functionality.

![GroupedListView Example](https://github.com/hamed-rezaee/flutter_sticky_group_list/blob/master/demo.gif?raw=true)

## Features

- **Group items:** Organize list items by group with customizable headers.
- **Sticky headers:** Keep group headers visible while scrolling.
- **Sorting:** Easily sort items within groups in ascending or descending order.
- **Pull-to-refresh:** Add a refresh indicator for easy updates.
- **Load more indicator:** Show a loading indicator at the bottom when fetching more items.
- **Customizable UI:** Flexible design with options for separators, paddings, physics, and more.

## Installation

Add the package to your Flutter project by including the following in your pubspec.yaml:

```yaml
dependencies:
  flutter_sticky_group_list: <LATEST_VERSION>
```

Then, run `flutter pub get` to install the package.

## Usage

Here’s how to integrate the `GroupedListView` in your Flutter project:

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Grouped List View Example')),
          body: GroupedListView<String, String>(
            order: GroupedListViewOrder.ascending,
            hasStickyHeader: true,
            hasRefreshIndicator: true,
            items: ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'],
            groupBy: (item) => item![0],
            groupBuilder: (group) => Container(
              padding: EdgeInsets.all(8),
              color: Colors.blueAccent,
              child: Text(
                group,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            itemBuilder: (item) => ListTile(title: Text(item)),
            onRefresh: () async {
              // Add refresh logic here.
            },
          ),
        ),
      );
}
```

## API Reference

### Constructor Parameters

- **itemBuilder (required):** A function that generates widgets for each item.
- **items (optional):** A list of items to display.
- **groupBy (optional):** A function that maps an item to its group.
- **groupBuilder (optional):** A function that generates a widget for the group header.
- **separator (optional):** A widget to display between list items.
- **controller (optional):** A ScrollController to control the scroll position.
- **sort (optional):** Whether to sort items (default: true).
- **sortPredicate (optional):** A custom comparator function for sorting items.
- **order (optional):** Sorting order (ascending or descending).
- **hasStickyHeader (optional):** Whether to enable sticky headers (default: false).
- **hasRefreshIndicator (optional):** Whether to enable pull-to-refresh (default: false).
- **onRefresh (optional):** A handler for refresh events.

### GroupedListViewOrder Enum

- **ascending:** Sort items in ascending order.
- **descending:** Sort items in descending order.

## Example App

Check out the `/example` directory in this repository for a complete application demonstrating the features of `GroupedListView`.

## Contributing

If you encounter any issues or have suggestions for improvements, please open an issue on GitHub. We welcome contributions and pull requests to enhance this package.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
