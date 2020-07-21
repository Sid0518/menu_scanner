import 'package:flutter/material.dart';
import 'package:menu_scanner/imports.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService auth = AuthService();

  Future<void> login(BuildContext context) async {
    FirebaseUser firebaseUser = await this.auth.getUser;
    loginUser(context, this.auth, forceSignIn: true);
  }

  @override
  void initState() {
    super.initState();

    this.login(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Splash Screen',
            
            style: TextStyle(
              fontSize: 24,
            ),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
      )
    );
  }
}