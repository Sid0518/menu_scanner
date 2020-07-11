import 'package:menu_scanner/imports.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        
        child: Center(
          child: Text(
            'To upload a file, you must sign in first by tapping the person icon',
            
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
          try {
            FirebaseUser firebaseUser = await this.auth.googleSignIn();
            user.firebaseUser = firebaseUser;
          } 
          catch (error) {
            print('Login Failed - $error');
          }
        },
      ),
    );
  }
}
