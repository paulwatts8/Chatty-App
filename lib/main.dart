import 'package:chat_app/screens/dashboard.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/screens/search.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Auth().handleAuth(),
        routes: <String, WidgetBuilder>{
          '/register': (BuildContext context) => new RegisterPage(),
          '/dashboard': (BuildContext context) => new Dashboard(),
          '/login': (BuildContext context) => new LoginPage(),
          '/search': (BuildContext context) => new Search(),
        });
  }
}
