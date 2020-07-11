import 'package:menu_scanner/imports.dart';

Future<String> uploadFile(User user, File file) async {
  StorageReference storageReference = FirebaseStorage.instance
    .ref()
    .child('${user.id}');

  StorageUploadTask uploadTask = storageReference
    .putFile(file);
  await uploadTask.onComplete;

  String url = await storageReference.getDownloadURL();
  Firestore.instance
    .collection('users')
    .document(user.id)
    .setData({
      'name': user.name, 
      'email': user.email,
      'url': url,
    });

  return url;
}
