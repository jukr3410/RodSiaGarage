import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service"),
        actions: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, ADD_SERVICE_ROUTE),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Center(
        child: Text("Register Garage"),
      ),
    );
  }
}
