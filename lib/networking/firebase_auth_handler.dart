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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);

      final user = userCredential.user;
      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('Sign In ${user.uid} with Google'),
      // ));
    } catch (e) {
      print(e);
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Failed to sign in with Google: $e'),
      //   ),
      // );
    }
  }

  bool isUserLoggedIn() {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  void listenAuthStateChanges() {
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
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
