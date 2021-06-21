// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/business_logic/viewmodels/cart_viewmodel.dart';
import 'package:firebase_demo/business_logic/viewmodels/home_viewmodel.dart';
import 'package:firebase_demo/business_logic/viewmodels/login_viewmodel.dart';
import 'package:firebase_demo/ui/pages/error_page.dart';
import 'package:firebase_demo/ui/pages/home_page.dart';
import 'package:firebase_demo/ui/pages/loading_page.dart';
import 'package:firebase_demo/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'networking/firebase_auth_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoginViewModel()),
            ChangeNotifierProvider(create: (context) => HomeViewModel()),
            ChangeNotifierProvider(create: (context) => CartViewModel()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: snapshot.hasError
                ? ErrorPage()
                : (snapshot.connectionState == ConnectionState.done
                    ? FirebaseAuthHandler().isUserLoggedIn()
                        ? HomePage()
                        : LoginPage()
                    : LoadingPage()),
          ),
        );
      },
    );
  }
}
