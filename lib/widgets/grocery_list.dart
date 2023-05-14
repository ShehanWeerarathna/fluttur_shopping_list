import 'package:flutter/material.dart';
import 'package:my_app/models/dummy_items.dart';

import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _addItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const NewItem();
    }));
  }

  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
            itemCount: groceryItems.length,
            itemBuilder: (context, index) => ListTile(
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: groceryItems[index].category.color,
                  ),
                  trailing: Text('${groceryItems[index].quantity}'),
                  title: Text(groceryItems[index].name),
                )));
  }
}
