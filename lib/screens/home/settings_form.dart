import 'package:flutter/material.dart';
import 'package:coffee_order_app/shared/constant.dart';

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
              value: _currentItem ?? 'A4 Bundle',
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
              value: (_currentQuantity ?? 1).toDouble(),
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
                print(_currentName);
                print(_currentItem);
                print(_currentQuantity);  
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
  }
}