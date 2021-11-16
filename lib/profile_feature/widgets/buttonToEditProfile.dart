import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';

class buttonToEditProfile extends StatefulWidget {
  Garage garage;
  buttonToEditProfile({Key? key, required this.garage}) : super(key: key);

  @override
  _buttonToEditProfileState createState() => _buttonToEditProfileState();
}

class _buttonToEditProfileState extends State<buttonToEditProfile> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          navigatorToEditProfile();
        },
        child: Text(
          tEdit,
          style: TextStyle(fontSize: fontSizeL, color: Colors.white),
        ));
  }

  void navigatorToEditProfile() {
    Navigator.pushNamed(context, EDITPROFILE_ROUTE, arguments: widget.garage);
  }
}
