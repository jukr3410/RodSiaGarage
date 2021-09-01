import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';

class BarTrackingpage extends StatefulWidget {
  BarTrackingpage({Key? key}) : super(key: key);

  @override
  _BarTrackingpageState createState() => _BarTrackingpageState();
}

class _BarTrackingpageState extends State<BarTrackingpage> {
  final String iconPhone = 'image/icon-phone.png';
  final String iconMessage = 'image/icon-message.png';
  final String iconMore = 'image/icon-more.png';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GFIconButton(
            color: bgColor,
            icon: ImageIcon(
              AssetImage(iconPhone),
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Expanded(
          child: GFIconButton(
            color: bgColor,
            icon: ImageIcon(
              AssetImage(iconMessage),
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Expanded(
          child: GFIconButton(
            color: bgColor,
            icon: ImageIcon(
              AssetImage(iconMore),
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
