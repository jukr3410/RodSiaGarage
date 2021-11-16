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
          tImageAsset(image),
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
    fontSize: fontSizeM,
  );
  TextStyle _textStyleBig =
      TextStyle(fontSize: fontSizeXXl, fontWeight: FontWeight.w400);

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
                    Flexible(
                      flex: 7,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            tImageAsset('profile2'),
                            width: 27,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(
                                  fontSize: 5,
                                ),
                                text: TextSpan(
                                  text: 'BMW center',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: fontSizeXXl,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Kanit'),
                                )),
                          )
                        ],
                      ),
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
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: defualtPaddingMedium,
                            ),
                            Column(
                              children: [
                                Text(
                                  tEstimateDuration,
                                ),
                                Text(
                                  '10.20 - 10.35',
                                  style: _textStyleBig,
                                )
                              ],
                            ),
                            SizedBox(
                              height: defualtPaddingMedium,
                            ),
                            _textInfo(
                              'Honda civic 1.6L',
                              'car',
                            ),
                            _textInfo(
                              '2.5 กิโลเมตร',
                              'distance',
                            ),
                            _textInfo(
                              'ถนนพระราม 2 ซอยท่าข้าม 20',
                              'location2',
                            ),
                            _textInfo(
                              'ตอนนี้รถเป็นอะไรก็ไม่รู้ สตาร์ทไม่ติด',
                              'desc',
                            ),
                            SizedBox(
                              height: defualtPaddingLow,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(tImageAsset('location-requestCard')),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: ImageIcon(AssetImage(tImageAsset('call'))),
                    onPressed: () {}),
                SizedBox(
                  width: 100,
                ),
                IconButton(
                    icon: ImageIcon(AssetImage(tImageAsset('message'))),
                    onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
