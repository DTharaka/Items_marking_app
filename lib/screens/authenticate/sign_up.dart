import 'package:coffee_order_app/shared/constant.dart';
import 'package:coffee_order_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_order_app/services/auth.dart';

class SignUp extends StatefulWidget {
  // SignUp({Key key}) : super(key: key);

  final Function toggleView;
  SignUp({this.toggleView}); // This is a constructor for the widget

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService(); // Create an instance of AuthService Class
  final _formKey = GlobalKey<FormState>(); // Identify and Assosiate with the form
  bool loading = false;

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
       backgroundColor: Colors.brown[100],
       appBar: AppBar(
         backgroundColor: Colors.brown[400],
         elevation: 0.0,
         title: Text('Sign up to Food Order'),
         actions: <Widget>[
           FlatButton.icon(
             icon: Icon(Icons.person), 
             label: Text('Sign in'),
             onPressed: (){
               widget.toggleView();
             }
          )
         ],
       ),
       body: Container(
         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
         child: Form(
           key: _formKey,
           child: Column(
             children: <Widget>[
               SizedBox(height: 20.0),
               TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'Email'),
                 validator: (val) => val.isEmpty ? 'Enter an e-mail' : null,
                 onChanged: (val){
                   setState(() {
                     email = val;
                   });
                 }
                ),
               SizedBox(height: 20.0),
               TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'Password'),
                 obscureText: true,
                 validator: (val) => val.length < 6 ? 'Enter a pssword 6+ characters long' : null,
                 onChanged: (val){
                   setState(() {
                     password = val;
                   });
                 }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signUpWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Please provide an valid email address';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0)
                )
             ],
           ),
          ),
       ),
    );
  }
}