import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class AlertShowChangeStatus extends StatefulWidget {
  AlertShowChangeStatus({Key? key}) : super(key: key);

  @override
  _AlertShowChangeStatusState createState() => _AlertShowChangeStatusState();
}

class _AlertShowChangeStatusState extends State<AlertShowChangeStatus> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthLow,
        decoration: BoxDecoration(
          borderRadius: borderRadiusLow,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingLow),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'คุณพึงเปลี่ยนสถานะของร้าน!',
                style: TextStyle(color: textColorBlack, fontSize: fontSizeXl),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: buttonHeightSmall - 10,
                  width: buttonWidthSmall - 20,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(tOKThai),
                    style: flatButtonStyle(primaryColor, textColorBlack),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
