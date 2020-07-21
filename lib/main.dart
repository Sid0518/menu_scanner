import 'imports.dart';

/*
  The ChangeNotifierProvider (part of the Provider package) 
  will update any page of the app that uses the User
  object
  So when the User object is changed in any way, this guy will
  notify every page dependent on the User object to also change
*/
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
      ],

      child: MaterialApp(
        home: SplashScreen(), // SplashScreen shows up when the app is opened
        
        theme: ThemeData(
          primaryColor: Color.fromRGBO(16, 76, 145, 1),
          accentColor: Color.fromRGBO(31, 138, 192, 1)
        ),
      ),
    )
  );
}
