import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String?> uploadImageToFirebase({required File imageFile}) async {
    try {
      // Create a unique filename for the image
      String fileName = DateTime.now().toString();

      // Reference to the Firebase Storage bucket
      Reference reference =
          FirebaseStorage.instance.ref().child('images').child(fileName);

      // Upload the image to Firebase Storage
      UploadTask uploadTask = reference.putFile(imageFile);

      // Get the download URL of the uploaded image
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the download URL of the image
      return imageUrl;
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
      return null;
    }
  }
}
