import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_model.dart';

@immutable
class EditServiceScreen extends StatefulWidget {
  Service service;
  EditServiceScreen({Key? key, required this.service}) : super(key: key);

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: iconColorBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Let's create a new instance of the home page
            // Navigator.pushReplacement(
            //   context,
            //   MAIN_ROUTE
            // );
          },
        ),
      ),
      body: Center(
        child: Text(
          "Edit Service",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColorBlack,
              fontSize: fontSizeLarge),
        ),
      ),
    );
  }
}
