import 'package:flutter/material.dart';
import 'package:my_app/models/grocery_item.dart';

import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

final List<GroceryItem> _groceryItems = [];

class _GroceryListState extends State<GroceryList> {
  void _addItem() async {
    final newItem = await Navigator.of(context)
        .push<GroceryItem>(MaterialPageRoute(builder: (context) {
      return const NewItem();
    }));
    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  void _removeItem(String id) {
    setState(() {
      _groceryItems.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items yet!'),
    );
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index].id);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text('${_groceryItems[index].quantity}'),
            title: Text(_groceryItems[index].name),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
