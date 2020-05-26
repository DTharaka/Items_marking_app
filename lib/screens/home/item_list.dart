import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_order_app/models/item.dart';
import 'package:coffee_order_app/screens/home/item_tile.dart';

import 'item_tile.dart';

class ItemList extends StatefulWidget {
  ItemList({Key key}) : super(key: key);

  @override 
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {

    final items = Provider.of<List<Item>>(context);

    return ListView.builder(
       itemCount: items.length,
       itemBuilder: (context,index){
         return ItemTile(item: items[index]);
       },
    );
  }
}