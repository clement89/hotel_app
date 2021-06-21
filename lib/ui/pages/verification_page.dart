import 'dart:async';

import 'package:firebase_demo/business_logic/viewmodels/login_viewmodel.dart';
import 'package:firebase_demo/ui/pages/home_page.dart';
import 'package:firebase_demo/ui/widgets/filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _controller = TextEditingController();
  late StreamController<ErrorAnimationType> _streamController;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final PageRouteBuilder _homeRoute = new PageRouteBuilder(
    pageBuilder: (BuildContext context, _, __) {
      return HomePage();
    },
  );

  @override
  void initState() {
    _streamController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/firebase.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10, 10, 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter verification code send to number +91 9048400799.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "Please enter the verification code";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        // inactiveFillColor: Colors.white,
                        // selectedFillColor: Colors.white,
                        // disabledColor: Colors.white,
                        // inactiveColor: Colors.white,
                        // activeColor: Colors.white,
                        // selectedColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        // borderWidth: 5,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 50,
                        // activeFillColor: hasError ? Colors.green : Colors.white,
                      ),

                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: TextStyle(
                        fontSize: 20,
                        height: 1.6,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      enableActiveFill: false,

                      errorAnimationController: _streamController,
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.white,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FilledButton(
                  title: 'Verify',
                  onClickAction: () async {
                    bool result =
                        await _loginViewModel.verifyNumber(_controller.text);
                    if (result) {
                      Navigator.pushAndRemoveUntil(
                          context, _homeRoute, (Route<dynamic> r) => false);
                    } else {
                      final snackBar =
                          SnackBar(content: Text('Something went wrong!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  color: Colors.blue,
                  image: '',
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
