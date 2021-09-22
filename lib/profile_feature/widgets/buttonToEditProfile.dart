import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class buttonToEditProfile extends StatefulWidget {
  buttonToEditProfile({Key? key}) : super(key: key);

  @override
  _buttonToEditProfileState createState() => _buttonToEditProfileState();
}

class _buttonToEditProfileState extends State<buttonToEditProfile> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          tEdit,
          style: TextStyle(fontSize: fontSizeMedium, color: Colors.white),
        ));
  }
}
