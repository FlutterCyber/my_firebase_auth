import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_firebase_auth/pages/sign_in_page.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static bool isSignedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static Future<User?> signInUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser;
  }

  static Future<User?> signUpUser(
      String fullName, String email, String password) async {
    var authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = authResult.user;
    return user;
  }

  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }
}
