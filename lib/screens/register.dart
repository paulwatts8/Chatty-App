import 'package:chat_app/services/authentication.dart';
import 'package:chat_app/services/helperfunctions.dart';
import 'package:chat_app/widgets/flat_widgets/flat_action_btn.dart';
import 'package:chat_app/widgets/flat_widgets/flat_input_box.dart';
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
            ? Container(color: Color(0xff5B428F),
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: EdgeInsets.only(top: 120),
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
                                      iconData: Icons.person,
                                      iconSize: 24.0,
                                      iconColor: Colors.grey,
                                    ),
                                    onChanged: usernameController,
                                    obsecureText: false,
                                    validator: (value) {
                                      return value.isEmpty || value.length < 3
                                          ? "Please provide a username"
                                          : null;
                                    },
                                    roundedCorners: true,
                                    hintText: 'Username',
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
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
                                return value.isEmpty
                                    ? 'Input an Email adderss'
                                    : null;
                              },
                              roundedCorners: true,
                              hintText: 'Email',
                              textInputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FlatInputBox(
                              prefix: FlatActionButton(
                                iconData: Icons.lock,
                                iconSize: 24.0,
                                iconColor: Colors.grey,
                              ),
                              onChanged: passwordController,
                              obsecureText: true,
                              validator: (value) {
                                return value.length > 6
                                    ? null
                                    : 'Please provide a password  ';
                              },
                              roundedCorners: true,
                              hintText: 'Password',
                            ),
                            SizedBox(height: 100),
                            GestureDetector(
                              onTap: () {
                                signUp();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    color: Color(0xff5B428F),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ),
                            FlatButton(
                                child: new Text('Already a member! Login',
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/login');
                                }),
                          ],
                        ),
                      )),
                ),
              ));
  }
}
