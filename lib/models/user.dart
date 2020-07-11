import 'package:menu_scanner/imports.dart';

class User extends ChangeNotifier {
  FirebaseUser _firebaseUser;
  User({FirebaseUser firebaseUser}) : this._firebaseUser = firebaseUser;

  set firebaseUser(FirebaseUser firebaseUser) {
    this._firebaseUser = firebaseUser;
    notifyListeners();
  }

  FirebaseUser get firebaseUser => this._firebaseUser;
  String get id => this._firebaseUser.uid;
  String get name => this._firebaseUser.displayName;
  String get email => this._firebaseUser.email;
}
