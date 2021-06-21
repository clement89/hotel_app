import 'package:firebase_demo/networking/firebase_auth_handler.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuthHandler _authHandler = FirebaseAuthHandler();

  String countryCode = '91';
  String phoneNumber = '';
  String phoneNumberError = '';

  bool isLoading = false;

  bool validatePhoneNumber() {
    phoneNumberError = phoneNumber.isEmpty ? 'Please enter phone number.' : '';
    if (phoneNumberError.isEmpty) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
      bool isValidNumber = RegExp(pattern).hasMatch(phoneNumber);
      phoneNumberError =
          isValidNumber ? '' : 'Please enter a valid phone number.';
    }
    if (phoneNumberError.isNotEmpty) {
      notifyListeners();
      return false;
    } else {
      sendVerificationCode();
      return true;
    }
  }

  Future<void> signInWithGoogle() async {
    await _authHandler.signInWithGoogle();
  }

  void sendVerificationCode() {
    print('+$countryCode $phoneNumber');
    _authHandler.verifyPhoneNumber('+$countryCode $phoneNumber');
  }

  Future<bool> verifyNumber(String code) async {
    bool result = await _authHandler.verifyCode(code);
    return result;
  }
}
