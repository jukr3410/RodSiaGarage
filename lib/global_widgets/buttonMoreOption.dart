import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class ButtonMoreOption extends StatefulWidget {
  ButtonMoreOption({Key? key}) : super(key: key);

  @override
  _ButtonMoreOptionState createState() => _ButtonMoreOptionState();
}

class _ButtonMoreOptionState extends State<ButtonMoreOption> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: ImageIcon(AssetImage(tImageAsset('moreOption'))),
        onPressed: () {});
  }
}
