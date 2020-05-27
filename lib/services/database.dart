import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/item.dart';
import 'package:coffee_order_app/models/user.dart';

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

  // userData daata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data[ 'name'],
      quantity: snapshot.data[ 'quantity'],
      item: snapshot.data[ 'item'],
    );
  }

  // Get items stream
  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }

  // Get user doc stream
  Stream<UserData> get userData {
    return itemCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}