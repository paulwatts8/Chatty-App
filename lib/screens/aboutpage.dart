import 'package:chat_app/widgets/flat_widgets/flat_info_page_wrapper.dart';
import 'package:chat_app/widgets/flat_widgets/flat_primary_button.dart';
import 'package:flutter/material.dart';

class Aboutpage extends StatefulWidget {
  static final String id = "Aboutpage";

  @override
  _AboutpageState createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatInfoPageWrapper(
        heading: "About Flat Social",
        subHeading: "Flutter UI Kit - v1.1",
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Flat Chat App created by Paul Watts. \n Credits to TVAC for the Flat Theme Widgets',
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).primaryColorDark.withOpacity(0.54),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        footer: Container(
          margin: EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: FlatPrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            prefixIcon: Icons.arrow_back,
            textAlign: TextAlign.right,
            text: "Back to Homepage",
          ),
        ),
      ),
    );
  }
}
