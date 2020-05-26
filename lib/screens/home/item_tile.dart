import 'package:flutter/material.dart';
import 'package:coffee_order_app/models/item.dart';

class ItemTile extends StatelessWidget {

  final Item item;
  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.black,
          ),
          title: Text(item.name),
          subtitle: Text('${item.name} wants ${item.quantity} pieces of ${item.item}'),
        ),
      ),
    );
  }
}