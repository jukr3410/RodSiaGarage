import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:rodsiagarage/constants.dart';

class ButtonTrackingStatus extends StatefulWidget {
  ButtonTrackingStatus({Key? key}) : super(key: key);

  @override
  _ButtonTrackingStatusState createState() => _ButtonTrackingStatusState();
}

class _ButtonTrackingStatusState extends State<ButtonTrackingStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: GFButton(
        color: bgColor,
        text: trackingStatus[0].toString(),
        textColor: textColorBlack,
        type: GFButtonType.solid,
        size: GFSize.LARGE,
        onPressed: () {},
      ),
    );
  }
}
