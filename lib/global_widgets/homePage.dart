import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Container(
        // padding: EdgeInsets.all(15.0),
        child: ImageIcon(AssetImage("assets/images/icon-home.png"),
            color: Colors.black, size: 35),
      ),
      elevation: 4.0,
      backgroundColor: Colors.grey.shade200,
    );
  }
}
