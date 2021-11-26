import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';

class DetailAndGiveStarPage extends StatefulWidget {
  RequestService requestService;
  DetailAndGiveStarPage({Key? key, required this.requestService})
      : super(key: key);

  @override
  _DetailAndGiveStarPageState createState() => _DetailAndGiveStarPageState();
}

class _DetailAndGiveStarPageState extends State<DetailAndGiveStarPage> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Container(
          alignment: Alignment.centerRight,
          child: GFButton(
            type: GFButtonType.transparent,
            textStyle: TextStyle(
                fontSize: 14, color: textColorBlack, fontFamily: 'Kanit'),
            child: Text(tSupportThai),
            onPressed: () {},
          ),
        ),
      ),
      body: Container(
        color: textColorWhite,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60,
                    child: ClipOval(
                      child: Image.asset(
                        tImageAsset('profile-homePage'),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    widget.requestService.user.name,
                    style: TextStyle(fontSize: fontSizeXXl),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'บริการที่ใช้:',
                                  style: TextStyle(
                                      fontSize: fontSizeXl,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget
                                      .requestService.service.serviceType.name,
                                ),
                                SizedBox(height: 5),
                                Text(widget.requestService.service.name),
                                SizedBox(height: 5),
                                Text(
                                  tMoreInfoThai,
                                  softWrap: true,
                                  maxLines: 3,
                                ),
                                SizedBox(height: 5),
                                Text('เวลา'),
                                SizedBox(height: 20),
                                Text(
                                  'สถานที่: ',
                                  style: TextStyle(
                                      fontSize: fontSizeXl,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.requestService.addressUser,
                                  softWrap: true,
                                  maxLines: 3,
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          height: buttonHeightSmall + 5,
                          width: buttonWidthLarge,
                          child: TextButton(
                            onPressed: () {
                              navigateToHome();
                            },
                            child: Text(tBackToHomePage),
                            style:
                                flatButtonStyle(primaryColor, textColorBlack),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  navigateToHome() {
    Navigator.pushReplacementNamed(context, MAIN_ROUTE);
  }
}
