import 'package:firebase_demo/business_logic/viewmodels/login_viewmodel.dart';
import 'package:firebase_demo/ui/pages/verification_page.dart';
import 'package:firebase_demo/ui/widgets/filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneNumberPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/firebase.png'),
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10, 10, 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your mobile number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0XFFF0F0F0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.2,
                              child: TextButton(
                                onPressed: () {
                                  print('show country picker..');
                                },
                                child: Text(
                                  '+91',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.6,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 0, bottom: 15, top: 15, right: 0),
                                  hintText: 'Phone number',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<LoginViewModel>(
                        builder: (context, viewModel, child) =>
                            viewModel.phoneNumberError.isNotEmpty
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0),
                                      child: Text(
                                        '* ${viewModel.phoneNumberError} ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.7,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50),
                FilledButton(
                  title: 'Continue',
                  onClickAction: () {
                    _loginViewModel.phoneNumber = _controller.text;
                    if (_loginViewModel.validatePhoneNumber()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationPage(),
                        ),
                      );
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
