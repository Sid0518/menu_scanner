import 'package:menu_scanner/imports.dart';

Future<void> loginUser(
  BuildContext context, AuthService auth,
  {bool forceSignIn = false}
) async {
    User user = Provider.of<User>(context, listen: false);
    FirebaseUser firebaseUser = await auth.getUser;

    if (firebaseUser != null) {
      if(user.firebaseUser == null)
        user.firebaseUser = firebaseUser;

      bool exists;
      await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .get()
        .then(
          (snapshot) => (exists = snapshot.exists)
        );

      if(exists)
        Navigator.pushReplacement(context, 
          MaterialPageRoute(
            builder: (context) =>
              HomePage()
          )
        );

      else {
        if(forceSignIn) {
          await auth.signOut();
          user.signOut();
          
          Navigator.pushReplacement(context, 
            MaterialPageRoute(
              builder: (context) => 
                SignInPage()
            )
          );
        }

        else
          Navigator.pushReplacement(context, 
            MaterialPageRoute(
              builder: (context) => 
                RegistrationForm()
            )
          );
      }
    }

    else
      Navigator.pushReplacement(context, 
        MaterialPageRoute(
          builder: (context) => 
            SignInPage()
        )
      );
  }

/*
  Many functions may require us to 'await' them to resolve the Promise/Future
  In such cases, this function can be used to display a loading circle during
  the 'await'
*/
Future<dynamic> showLoadingDialog(BuildContext context, Function function) async {
  BuildContext dialogContext;

  //show the loading circle
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      dialogContext = context;

      return AlertDialog(
        content: Center(
          child: Container(
            height: 120, 
            width: 120, 
            
            child: CircularProgressIndicator()
          )
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
      );
    }
  );

  // call and await the async function
  dynamic returnValue = await function();

  // remove the loading circle once the function returns
  Navigator.pop(dialogContext);

  // return whatever was returned from the function we called and awaited
  return returnValue;
}
