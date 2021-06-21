import 'package:firebase_demo/business_logic/viewmodels/login_viewmodel.dart';
import 'package:firebase_demo/ui/pages/phone_number_page.dart';
import 'package:firebase_demo/ui/widgets/filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _viewModel = Provider.of<LoginViewModel>(context, listen: false);
    final PageRouteBuilder _homeRoute = new PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return HomePage();
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: size.height * 0.30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/firebase.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 100),
          FilledButton(
            title: 'Google',
            onClickAction: () async {
              bool result = await _viewModel.signInWithGoogle();
              if (result) {
                Navigator.pushAndRemoveUntil(
                    context, _homeRoute, (Route<dynamic> r) => false);
              } else {
                final snackBar = SnackBar(
                  content: Text('Error in login!'),
                  action: SnackBarAction(
                    label: 'Get in anyway',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context, _homeRoute, (Route<dynamic> r) => false);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            color: Colors.blue,
            image: 'google.png',
          ),
          SizedBox(height: 10),
          FilledButton(
            title: 'Phone',
            onClickAction: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PhoneNumberPage(),
                ),
              );
            },
            color: Colors.green,
            image: 'phone.png',
          ),
          SizedBox(
            height: 50,
          ),
        ],
      )),
    );
  }
}
