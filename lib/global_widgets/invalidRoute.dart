import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class InvalidRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColorRed,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
          "Invalid Route ! !",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColorRed,
              fontSize: fontSizeLarge),
        ),
      ),
    );
  }
}
