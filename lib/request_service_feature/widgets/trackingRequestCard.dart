import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class TrackingRequestCard extends StatefulWidget {
  TrackingRequestCard({Key? key}) : super(key: key);

  @override
  _TrackingRequestCardState createState() => _TrackingRequestCardState();
}

class _TrackingRequestCardState extends State<TrackingRequestCard> {
  Widget _textInfo(String desc, String image) {
    return Row(
      children: [
        Image.asset(
          image,
          width: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(
          desc,
          softWrap: true,
          style: _textStyleSmall,
        )),
        SizedBox(
          height: 7,
        ),
      ],
    );
  }

  TextStyle _textStyleSmall = TextStyle(
    fontSize: fontSizeLow,
  );
  TextStyle _textStyleBig = TextStyle(fontSize: fontSizeLarge);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthLarge,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadiusMediumOnlyTop,
                color: primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(defualtPaddingLow),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/icon-profile2.png',
                      width: 23,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'John Rider',
                      style: _textStyleBig,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: defualtPaddingMedium, right: defualtPaddingMedium),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: defualtPaddingLow,
                          ),
                          _textInfo(
                              'Honda civic 1.6L', 'assets/images/icon-car.png'),
                          _textInfo('2.5 กิโลเมตร',
                              'assets/images/icon-distance.png'),
                          _textInfo('ถนนพระราม 2 ซอยท่าข้าม 20',
                              'assets/images/icon-location2.png'),
                          _textInfo('ตอนนี้รถเป็นอะไรก็ไม่รู้ สตาร์ทไม่ติด',
                              'assets/images/icon-desc.png'),
                          SizedBox(
                            height: defualtPaddingLow,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                          'assets/images/icon-location-requestCard.png'),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: ImageIcon(AssetImage('assets/images/icon-call.png')),
                    onPressed: () {}),
                SizedBox(
                  width: 100,
                ),
                IconButton(
                    icon:
                        ImageIcon(AssetImage('assets/images/icon-message.png')),
                    onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
