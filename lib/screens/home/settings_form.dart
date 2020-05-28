import 'package:coffee_order_app/models/user.dart';
import 'package:coffee_order_app/services/database.dart';
import 'package:coffee_order_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_order_app/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  SettingForm({Key key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> item = ['A4 Bundle','R/B/BLK Pens','Stepler','Glue Bottle','Paper Cutter'];

  // Form values
  String _currentName;
  String _currentItem;
  int _currentQuantity;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          UserData userData = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your item settings',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration,
                        validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val){
                          setState(() {
                            _currentName = val;
                          });
                        }
                    ),
                    SizedBox(height: 20.0),
                    // Dropdown
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentItem,
                      items: item.map((e){
                        return DropdownMenuItem(
                          value: e,
                          child: Text('$e'),
                        );
                      }).toList(),
                      onChanged: (val){
                          setState(() {
                            _currentItem = val;
                          });
                      },
                    ),
                    // Slider
                    Slider(
                      value: (_currentQuantity ?? userData.quantity).toDouble(),
                      activeColor: Colors.red,
                      inactiveColor: Colors.red,
                      min: 1,
                      max: 5,
                      divisions: 5,
                      onChanged: (val){
                          setState(() {
                            _currentQuantity = val.round();
                          });
                      }
                    ),
                    //Button
                    RaisedButton(
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentItem ?? userData.item,
                            _currentQuantity ?? userData.quantity
                          );
                          Navigator.pop(context);
                        } 
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                ]
              ),
            );
        } else {
           return Loading();
        }
       }
    );
  }
}