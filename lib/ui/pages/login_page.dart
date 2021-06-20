import 'package:firebase_demo/ui/widgets/filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
            onClickAction: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => LoginPage(),
              //   ),
              // );
            },
            color: Colors.blue,
            image: 'google.png',

          ),
          SizedBox(height: 10),
          FilledButton(
            title: 'Phone',
            onClickAction: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => LoginPage(),
              //   ),
              // );
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
