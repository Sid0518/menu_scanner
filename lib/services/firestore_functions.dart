import 'package:menu_scanner/imports.dart';

Future<String> uploadFile(User user, File file) async {
  // get the location on the server where the file will be uploaded
  StorageReference storageReference = FirebaseStorage.instance
    .ref()
    .child('${user.id}');

  // start uploading the file
  StorageUploadTask uploadTask = storageReference
    .putFile(file);
  // wait till the file is fully uploaded
  await uploadTask.onComplete;

  // get the download url of the newly uploaded file
  String url = await storageReference.getDownloadURL();

  // save the url to Firestore in the current user's document
  Firestore.instance
    .collection('users')
    .document(user.id)
    .setData({
      'name': user.name, 
      'email': user.email,
      'url': url,
    });

  // return the download URL of the newly uploaded file
  return url;
}
