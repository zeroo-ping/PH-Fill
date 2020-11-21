import 'dart:io';

class Models {
  static String userRequest;
  static var userUid;
  static File image1;
  static String image1Url;
  static File image2;
  static String image2Url;
  static File image3;
  static String image3Url;

//   static firebaseImages() {
//     var ref = FirebaseStorage.instance
//         .ref()
//         .child('User picked image')
//         .child(Models.userUid + '.jpg');

//     ref.putFile(Models.image1).onComplete;
//     var url = ref.getDownloadURL();
//     Models.image1Url = url;
//   }
}
