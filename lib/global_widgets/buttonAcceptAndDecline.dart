import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class ButtonAcceptAndDecline extends StatefulWidget {
  ButtonAcceptAndDecline({Key? key}) : super(key: key);

  @override
  _ButtonAcceptAndDeclineState createState() => _ButtonAcceptAndDeclineState();
}

class _ButtonAcceptAndDeclineState extends State<ButtonAcceptAndDecline> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: buttonWidthSmall,
          height: buttonHeightSmall,
          child: TextButton(
            onPressed: () {},
            child: Text(tOKThai),
            style: flatButtonStyle(primaryColor, textColorBlack),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: buttonWidthSmall,
          height: buttonHeightSmall,
          child: TextButton(
            onPressed: () {},
            child: Text(tDeclineThai),
            style: flatButtonStyle(primaryColor, textColorBlack),
          ),
        ),
      ],
    );
  }
}
