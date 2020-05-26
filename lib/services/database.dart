import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/item.dart';

class DatabaseService {
  
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference itemCollection = Firestore.instance.collection('items');

  Future updateUserData(String name, String item, int quantity) async {
    return itemCollection.document(uid).setData({
      'name': name,
      'item': item,
      'quantity': quantity
    });
  }

  // Item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Item(
        name: doc.data['name'] ?? '',
        item: doc.data['item'] ?? 0,
        quantity: doc.data['quantity'] ?? 0
      );
    }).toList();
  }

  
  // Get items stream
  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }

}