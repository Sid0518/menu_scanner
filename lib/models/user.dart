import 'package:menu_scanner/imports.dart';

/*
  The User class wraps FirebaseUser within it, and 
  extends ChangeNotifier, so that it may be used by a 
  ChangeNotifierProvider (see main.dart)
*/
class User extends ChangeNotifier {
  FirebaseUser _firebaseUser;
  User({FirebaseUser firebaseUser}) : this._firebaseUser = firebaseUser;

  set firebaseUser(FirebaseUser firebaseUser) {
    this._firebaseUser = firebaseUser;
    notifyListeners();
  }

  // Added a few nifty getters to make life easy
  FirebaseUser get firebaseUser => this._firebaseUser;
  String get id => this._firebaseUser.uid;
  String get name => this._firebaseUser.displayName;
  String get email => this._firebaseUser.email;

  void signOut() {
    this._firebaseUser = null;
  }
}
