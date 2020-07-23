import 'package:chat_app/screens/dashboard.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/screens/search.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Color(0xff5B428F),
          accentColor: Color(0xffF56D58),
          primaryColorDark: Color(0xff262833),
          primaryColorLight: Color(0xffFCF9F5),
        ),
        darkTheme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Color(0xff5B428F),
          accentColor: Color(0xffF56D58),
          primaryColorDark: Color(0xffFFFFFF),
          primaryColorLight: Color(0xff000000),
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
