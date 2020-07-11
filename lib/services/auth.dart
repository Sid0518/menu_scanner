import 'package:menu_scanner/imports.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> get getUser => _auth.currentUser();
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<FirebaseUser> anonLogin() async {
    FirebaseUser user = (await _auth.signInAnonymously()).user;
    return user;
  }

  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);

      FirebaseUser user = result.user;

      return user;
    } catch (error) {
      print('Login failed - $error');
      return null;
    }
  }

  Future<void> signOut() async {
    _auth.signOut();
    await _googleSignIn.signOut();
  }
}
