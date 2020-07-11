import 'package:menu_scanner/imports.dart';
import 'dart:math' as math;

class FileUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        
        child: Center(
          child: Text(
            'Tap on the paperclip icon to select a file for upload',
            
            style: TextStyle(fontSize: 24),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Transform.rotate(
          child: Icon(Icons.attach_file),
          angle: math.pi / 4,
        ),
        
        onPressed: () async {
          String url = 
            await showLoadingDialog(
              context, 
              () async {
                File file = await FilePicker.getFile(
                  // type: FileType.custom, allowedExtensions: ['pdf']
                  type: FileType.any);
                return uploadFile(user, file);
              }
            );
          
          showDialog(
            context: context,
            builder: (context) =>
              Dialog(
                child: Container(
                  height: 400,
                  width: 400,

                  child: QrImage(data: url)
                ),
              )
          );
        },
      ),
    );
  }
}
