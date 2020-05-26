import 'package:coffee_order_app/models/user.dart';
import 'package:coffee_order_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  
  // Create an instance/object of firebase authenticaton => to commu. with firebase auth. on the backend
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Create a user object based  on firebase user, this return a user so return type is User
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }
  
  // auth change user stream
  Stream<User> get user{
    // Here we convert firebaseUser to normal user based on custom user class
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }
  
  // Sign in anonymous
  Future signInAnonymous() async{
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

       // Create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('a new member', 'A4 Sheets Bundle', 2);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
    
  }

}