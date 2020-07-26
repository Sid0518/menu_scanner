import 'package:menu_scanner/imports.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        
        child: Center(
          child: Text(
            'Sign-In Page',
            
            style: TextStyle(
              fontSize: 24,
            ),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person),
        
        onPressed: () async {
          /*
            Attempt to use FirebaseAuth to prompt the user to login
            using Google
          */
          try {
            await this.auth.googleSignIn();
            loginUser(context, this.auth);
          } 
          catch (error) {
            print('Login Failed - $error');
          }
        },
      ),
    );
  }
}
