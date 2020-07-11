import 'imports.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
      ],

      child: MaterialApp(
        home: HomePage(),
        
        theme: ThemeData(
          primaryColor: Color.fromRGBO(16, 76, 145, 1),
          accentColor: Color.fromRGBO(31, 138, 192, 1)
        ),
      ),
    )
  );
}
