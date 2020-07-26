import 'package:menu_scanner/imports.dart';
import 'package:path/path.dart' as Path;

Future<void> registerUser({
  String id,
  String ownerName, String restaurantName, 
  String contactNo,
  String addressLine1, String addressLine2, 
  String city, String pinCode,
  String state,
}) async {
  String slug = createSlug(
    restaurantName: restaurantName,
    addressLine1: addressLine1,
    addressLine2: addressLine2,
    city: city
  );

  await Firestore.instance
    .collection('users')
    .document(id)
    .setData({
      'ownerName': ownerName,
      'restaurantName': restaurantName,
      'contactNo': contactNo,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'slug': slug
    }, merge: true);
}

Future<String> uploadFile(User user, File file) async {
  // get the location on the server where the file will be uploaded
  String fileExtension = Path.extension(file.path);
  StorageReference storageReference = FirebaseStorage.instance
    .ref()
    .child('${user.id}$fileExtension');

  // start uploading the file
  StorageUploadTask uploadTask = storageReference
    .putFile(file);
  // wait till the file is fully uploaded
  await uploadTask.onComplete;

  // get the download url of the newly uploaded file
  String url = await storageReference.getDownloadURL();

  // save the url to Firestore in the current user's document
  await Firestore.instance
    .collection('users')
    .document(user.id)
    .setData({
      'url': url,
    }, merge: true);

  // return the user's restaurant slug
  return user.getAttribute('slug');
}
