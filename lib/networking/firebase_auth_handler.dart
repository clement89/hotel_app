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
  late String _verificationId;
  late User user;

  // Example code of how to verify phone number
  Future<void> verifyPhoneNumber(String number) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Failed to Verify Phone Number: $e');
    }
  }

  Future<bool> verifyCode(String code) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: code,
      );
      user = (await _auth.signInWithCredential(credential)).user!;

      print('Successfully signed in UID: ${user.uid}');
      return true;
    } catch (e) {
      print('Failed to sign in - $e');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
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

      user = userCredential.user!;
      return true;
    } catch (e) {
      print(e);
      return false;
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
