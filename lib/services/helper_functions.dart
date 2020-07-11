import 'package:menu_scanner/imports.dart';

Future<dynamic> showLoadingDialog(BuildContext context, Function function) async {
  BuildContext dialogContext;

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

  dynamic returnValue = await function();
  Navigator.pop(dialogContext);

  return returnValue;
}
