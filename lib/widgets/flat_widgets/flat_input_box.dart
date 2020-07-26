import 'package:flutter/material.dart';

class FlatInputBox extends StatelessWidget {
  final Widget prefix;
  final Widget suffix;
  final bool roundedCorners;
  final TextEditingController onChanged;
  final Function validator;
  final Function onPressed;
  final String hintText;
  final TextInputType textInputType;
  final bool obsecureText;
  FlatInputBox(
      {this.prefix,
      this.suffix,
      this.roundedCorners,
      this.onChanged,
      this.validator,
      this.onPressed,
      this.hintText,
      this.textInputType,
      this.obsecureText});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            prefix ??
                SizedBox(
                  width: 0,
                  height: 0,
                ),
            Expanded(
              child: new TextFormField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(
                    16.0,
                  ),
                ),
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                maxLines: 1,
                keyboardType: textInputType,
                autofocus: false,
                validator: validator,
                obscureText: obsecureText,
                controller: onChanged,
              ),
            ),
            suffix ??
                SizedBox(
                  width: 0,
                  height: 0,
                ),
          ],
        ),
      ),
    );
  }
}

Widget showPasswordInput() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
    child: new TextFormField(
      maxLines: 1,
      obscureText: true,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Password',
          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
          )),
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      // onSaved: (value) => _password = value.trim(),
    ),
  );
}
