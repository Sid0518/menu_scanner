import 'package:menu_scanner/imports.dart';
import 'dart:math' as math;

class FileUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
      The ChangeNotifierProvider from main.dart will tell
      this user object below, 'Hey, you have been changed,
      redraw this page'
    */
    User user = Provider.of<User>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        
        child: Center(
          child: Text(
            'Tap on the paperclip icon to attach your menu file',
            
            style: TextStyle(fontSize: 24),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Attach Menu',

        child: Transform.rotate(
          child: Icon(Icons.attach_file),
          angle: math.pi / 4,
        ),
        
        onPressed: () async {
          /*
            -> The line below will first show a file picker page
            on the app, let the user select a file, and return
            this file to us
            -> Then it will upload the file to Firebase
            -> The entire time that the file is being uploaded,
               the user is shown a CircularProgressIndicator

            (FilePicker is part of the file_picker package, not 
             available by default in Flutter)
          */
          String slug = 
            await showLoadingDialog(
              context, 
              () async {
                File file = await FilePicker.getFile(
                  type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']
                  // type: FileType.any
                );

                if(file != null)
                  return await uploadFile(user, file);
                else
                  return null;
              },
              finishMessage: 'Menu has been uploaded successfully',
          );
          /*
            Once the file is uploaded, the URL of the
            newly uploaded file is encoded into a QR Code
            and displayed to the user in a Dialog box

            (QrImage is part of the qr-flutter package, not 
             available by default in Flutter)
          */

          if(slug != null)
            showDialog(
              context: context,
              builder: (context) =>
                Dialog(
                  child: Container(
                    height: 400,
                    width: 400,

                    child: QrImage(data: 'https://restaurantthing.com/res/$slug')
                  ),
                )
            );
        },
      ),
    );
  }
}
