import 'package:coffee_order_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_order_app/services/database.dart';
import 'package:coffee_order_app/screens/home/item_list.dart';
import 'package:coffee_order_app/models/item.dart';


class Home extends StatelessWidget {
  // const Home({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
          value: DatabaseService().items,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Food Order'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person), 
              label: Text('Logout'),
              onPressed: () async{
                await _auth.signOut();
              }
            )
          ]
        ),
        body: ItemList(),
      ),
    );
  }
}