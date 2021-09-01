import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';

class NameGarageAndUser extends StatefulWidget {
  NameGarageAndUser({Key? key}) : super(key: key);

  @override
  _NameGarageAndUserState createState() => _NameGarageAndUserState();
}

class _NameGarageAndUserState extends State<NameGarageAndUser> {
  final trackingStatus = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Container(
            color: bgColor,
            height: 50,
            child: Column(
              children: [
                Text(tNameGarageThai),
                Text('xxxxxxxxxxxxxx'),
              ],
            ),
          )),
          SizedBox(
            width: 2,
          ),
          Expanded(
              child: Container(
            color: bgColor,
            height: 50,
            child: Column(
              children: [
                Text(tNameUserThai),
                Text('xxxxxxxxxxxxxx'),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
