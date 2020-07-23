import 'package:chat_app/services/authentication.dart';
import 'package:chat_app/services/helperfunctions.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signUp() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Auth()
          .registerNewUser(emailController.text, passwordController.text,
              usernameController.text)
          .then((value) {
        //setting username and email + setting them as loggedIn
        HelperFunction.saveUserEmailSharedPrefences(usernameController.text);
        HelperFunction.saveUserNamePrefence(usernameController.text);
        HelperFunction.saveuserLoggedInStatus(true);
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed('/dashboard');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
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
                                    validator: (val) {
                                      return val.isEmpty || val.length < 3
                                          ? "Please provide a username"
                                          : null;
                                    },
                                    controller: usernameController,
                                    decoration:
                                        InputDecoration(hintText: 'Username'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty
                                    ? 'Input an Email adderss'
                                    : null;
                              },
                              controller: emailController,
                              decoration: InputDecoration(hintText: 'Email'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.length > 6
                                    ? val
                                    : 'Please provide a password  ';
                              },
                              controller: passwordController,
                              decoration:
                                  InputDecoration(hintText: 'Password '),
                              obscureText: true,
                            ),
                            SizedBox(height: 50),
                            GestureDetector(
                              onTap: () {
                                signUp();
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
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ));
  }
}
