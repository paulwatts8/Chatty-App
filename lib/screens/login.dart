import 'package:chat_app/screens/dashboard.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/helperfunctions.dart';
import 'package:chat_app/widgets/flat_widgets/flat_action_btn.dart';
import 'package:chat_app/widgets/flat_widgets/flat_input_box.dart';
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
  bool profilePic = false;

  QuerySnapshot usernameSnapshot;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
              context, MaterialPageRoute(builder: (context) => Dashboard()));
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
        body: isLoading
            ? Container(
                color: Color(0xff5B428F),
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: EdgeInsets.only(top: 100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: _formkey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      image: DecorationImage(
                                        image:
                                            AssetImage("assets/chattylogo.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60.0,
                                  ),
                                  FlatInputBox(
                                    prefix: FlatActionButton(
                                      iconData: Icons.email,
                                      iconSize: 24.0,
                                      iconColor: Colors.grey,
                                    ),
                                    onChanged: emailController,
                                    obsecureText: false,
                                    validator: (value) {
                                      return null;
                                    },
                                    roundedCorners: true,
                                    hintText: 'Email',
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FlatInputBox(
                                    prefix: FlatActionButton(
                                      iconData: Icons.lock,
                                      iconSize: 24.0,
                                      iconColor: Colors.grey,
                                    ),
                                    obsecureText: true,
                                    onChanged: passwordController,
                                    validator: (value) {
                                      return value.length > 6
                                          ? null
                                          : 'Please provide a password  ';
                                    },
                                    roundedCorners: true,
                                    hintText: 'Password',
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "Forgot Password",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 70),
                                  GestureDetector(
                                    onTap: () {
                                      signIn();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: Color(0xff5B428F),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  FlatButton(
                                      child: new Text('New Member? Register',
                                          style: new TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w300)),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/register');
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
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
