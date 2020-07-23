import 'package:chat_app/screen/chatpage.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/helperfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  QuerySnapshot usernameSnapshot;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  // signIn() async {
  //   if (_formkey.currentState.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     await DB().getUserName(emailController.text).then((value) {
  //       value = usernameSnapshot;
  //       HelperFunction.saveuserLoggedInStatus(true);
  //       HelperFunction.saveUserNamePrefence(
  //           usernameSnapshot.documents[0].data['username']);
  //       HelperFunction.saveUserEmailSharedPrefences(emailController.text);
  //     });
  //     Auth()
  //         .signwithEmailandPass(emailController.text, passwordController.text)
  //         .then((value) {
  //       if (value != null) {}
  //       Navigator.pushReplacementNamed(context, '/dashboard');
  //     });
  //   }
  // }

  signIn() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await Auth()
          .signwithEmailandPass(emailController.text, passwordController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DB().getUserName(emailController.text);
          HelperFunction.saveuserLoggedInStatus(true);
          HelperFunction.saveUserNamePrefence(
              userInfoSnapshot.documents[0].data["username"]);
          HelperFunction.saveUserEmailSharedPrefences(
              userInfoSnapshot.documents[0].data["email"]);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatPage()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: EdgeInsets.only(top: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(hintText: 'Email'),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          validator: (value) {
                            return value.length > 6
                                ? null
                                : 'Please provide a password  ';
                          },
                          decoration: InputDecoration(
                            hintText: 'Password ',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password",
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            signIn();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color(0xff068F29),
                                  const Color(0xff04632D)
                                ]),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color(0xff068F29),
                                  const Color(0xff04632D)
                                ]),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Sign in with Google",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Text(
                                  "Dont have an account?",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      fontSize: 15),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
