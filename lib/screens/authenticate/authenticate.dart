import 'package:coffee_order_app/screens/authenticate/sign_in.dart';
import 'package:coffee_order_app/screens/authenticate/sign_up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool isShowSignIn = true;
  void toggleView(){
    setState(() {
      isShowSignIn = !isShowSignIn; 
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isShowSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return SignUp(toggleView: toggleView);
    }
    // return Container(
    //    child: SignUp(),
    // );
  }
}