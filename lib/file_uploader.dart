import 'dart:ffi';

import 'imports.dart';

class FileUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),

        child: Center(
          child: Text(
            'Tap on the paperclip icon to select a file for upload',

            style: TextStyle(
              fontSize: 24
            ),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.attach_file),

        onPressed: () async {
          File file = await FilePicker.getFile(
//            type: FileType.custom, allowedExtensions: ['pdf']
            type: FileType.any
          );

          // Upload file to FirebaseStorage
        },
      ),
    );
  }
}
