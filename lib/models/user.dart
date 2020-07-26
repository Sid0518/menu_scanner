import 'package:menu_scanner/imports.dart';

/*
  The User class wraps FirebaseUser within it, and 
  extends ChangeNotifier, so that it may be used by a 
  ChangeNotifierProvider (see main.dart)
*/
class User extends ChangeNotifier {
  FirebaseUser _firebaseUser;
  User({FirebaseUser firebaseUser}) : this._firebaseUser = firebaseUser;
  
  Map<String, dynamic> userData;

  Future<void> fetchData() async {
    this.userData = 
      (await Firestore.instance
        .collection('users')
        .document(this.id)
        .get()).data;
  }

  void updateData({  
    String ownerName, String restaurantName, 
    String contactNo,
    String addressLine1, String addressLine2, 
    String city, String pinCode,
    String state,
  }) {
    this.userData['ownerName'] = ownerName;
    this.userData['restaurantName'] = restaurantName;
    this.userData['contactNo'] = contactNo;

    this.userData['addressLine1'] = addressLine1;
    this.userData['addressLine2'] = addressLine2;

    this.userData['city'] = city;
    this.userData['pinCode'] = pinCode;

    this.userData['state'] = state;

    this.userData['slug'] = createSlug(
      restaurantName: restaurantName,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      city: city
    );
  }

  Future<void> initialize(FirebaseUser firebaseUser) async {
    this._firebaseUser = firebaseUser;
    await this.fetchData();

    notifyListeners();
  }

  String getAttribute(String attribute) => this.userData[attribute];

  // Added a few nifty getters to make life easy
  FirebaseUser get firebaseUser => this._firebaseUser;
  String get id => this._firebaseUser.uid;
  String get name => this._firebaseUser.displayName;
  String get email => this._firebaseUser.email;

  void signOut() {
    this._firebaseUser = null;
  }
}
