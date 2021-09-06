import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class EditServiceScreen extends StatelessWidget {
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
