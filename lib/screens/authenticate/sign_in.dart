import 'package:coffee_order_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  // SignIn({Key key}) : super(key: key);
  
  final Function toggleView;
  SignIn({this.toggleView}); // This is a constructor for the widget

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService(); // Create an instance of AuthService Class
  final _formKey = GlobalKey<FormState>(); // Identify and Assosiate with the form

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.brown[100],
       appBar: AppBar(
         backgroundColor: Colors.brown[400],
         elevation: 0.0,
         title: Text('Sign in to Food Order'),
         actions: <Widget>[
           FlatButton.icon(
             icon: Icon(Icons.person), 
             label: Text('Sign up'),
             onPressed: (){
               widget.toggleView();
             }
          )
         ],
       ),
       body: Container(
         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
         child: Form(
           child: Column(
             children: <Widget>[
               SizedBox(height: 20.0),
               TextFormField(
                 validator: (val) => val.isEmpty ? 'Enter an e-mail' : null,
                 onChanged: (val){
                   setState(() {
                     email = val;
                   });
                 }
                ),
               SizedBox(height: 20.0),
               TextFormField(
                 validator: (val) => val.length < 6 ? 'Enter a pssword 6+ characters long' : null,
                 obscureText: true,
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
                    'Sign in',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      dynamic result = _auth.signInWithEmailAndPassword(email, password);
                      
                      if (result == null) {
                        setState(() {
                          error = "Couldn't sign in with this email & password.";
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