// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/business_logic/viewmodels/cart_viewmodel.dart';
import 'package:firebase_demo/business_logic/viewmodels/home_viewmodel.dart';
import 'package:firebase_demo/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            ChangeNotifierProvider(create: (context) => HomeViewModel()),
            ChangeNotifierProvider(create: (context) => CartViewModel()),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: snapshot.hasError
                  ? HomePage()
                  : (snapshot.connectionState == ConnectionState.done
                      ? HomePage()
                      : HomePage())),
        );
      },
    );
  }
}