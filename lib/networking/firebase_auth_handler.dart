import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHandler {
  FirebaseAuthHandler._privateConstructor();

  static final FirebaseAuthHandler _instance =
      FirebaseAuthHandler._privateConstructor();

  factory FirebaseAuthHandler() {
    return _instance;
  }
  bool isUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  void listenAuthStateChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<dynamic> logout() async {
    print('logout......!!');

    listenAuthStateChanges();

    try {
      try {
        await FirebaseAuth.instance.signOut().then((value) {
          // successCallback();
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // errorCallback('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // errorCallback('Wrong password provided for that user.');
        }
      }
    } on SocketException {
      // errorCallback('No internet connection');
    }
  }
}
