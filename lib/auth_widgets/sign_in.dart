import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hacakthon_app/models/blueprint.dart';

//
//@override
//void initState() {
//  super.initState();
//  var auth = FirebaseAuth.instance;
//  auth.authStateChanges().listen((user) {
//    if (user != null) {
//      print("user is logged in");
//      Navigator.pushNamed(context, '2');
//
//      //navigate to home page using Navigator Widget
//    } else {
//      print("user is not logged in");
//      //navigate to sign in page using Navigator Widget
//      Navigator.pushNamed(context, '2');
//
//    }
//  });
//}

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();
Stream<User> get authStateChanges => _auth.authStateChanges();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  String email = ("${user.email}");
  //String photoUrl = ("${user.photoURL}");
  String userUsername = ("${user.displayName}");

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    Models.userUid = user.uid;

    await FirebaseFirestore.instance
        .collection('Users Login Info')
        .doc(user.uid)
        .set({
      'email': email,
      'username': userUsername,
      // 'image': photoUrl,
    });

    //print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}
