import 'package:menu_scanner/imports.dart';

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
