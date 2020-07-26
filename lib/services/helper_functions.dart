import 'package:menu_scanner/imports.dart';

Future<void> loginUser(
  BuildContext context, AuthService auth,
  {bool forceSignIn = false}
) async {
    User user = Provider.of<User>(context, listen: false);
    FirebaseUser firebaseUser = await auth.getUser;

    if (firebaseUser != null) {
      if(user.firebaseUser == null)
        await user.initialize(firebaseUser);

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
Future<dynamic> showLoadingDialog(
  BuildContext context, Function function, {String finishMessage}
) async {
  BuildContext dialogContext;

  //show the loading circle
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext buildContext) {
      dialogContext = buildContext;

      return WillPopScope(
        onWillPop: () async => false,
        
        child: AlertDialog(
          content: Center(
            child: SpinKitFoldingCube(
              color: Colors.white,
              size: 50.0,
              duration: Duration(milliseconds: 800),
            )
          ),

          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  );

  // call and await the async function
  dynamic returnValue = await function();

  // remove the loading circle once the function returns
  Navigator.pop(dialogContext);

  if(finishMessage != null)
    if(returnValue != null)
      Scaffold.of(context)
        .showSnackBar(
          SnackBar(content: Text(finishMessage))
        );
    // TODO: Add a different snackbar message if the function returned null

  // return whatever was returned from the function we called and awaited
  return returnValue;
}

String createSlug({
  String restaurantName, 
  String addressLine1, String addressLine2, 
  String city
}) {
  RegExp alphanumericFilter = RegExp(r"[A-Za-z0-9]+");
  String unformattedSlug = 
    [restaurantName, addressLine1, addressLine2, city]
      .join(' ');

  String slug = 
    alphanumericFilter
      .allMatches(unformattedSlug)
      .map((match) => match.group(0))
      .toList()
      .join('-')
      .toLowerCase();
  
  return slug;
}