import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class MoreInfoRequestCard extends StatefulWidget {
  MoreInfoRequestCard({Key? key}) : super(key: key);

  @override
  _MoreInfoRequestCardState createState() => _MoreInfoRequestCardState();
}

class _MoreInfoRequestCardState extends State<MoreInfoRequestCard> {
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
    fontSize: fontSizeM,
  );
  TextStyle _textStyleBig =
      TextStyle(fontSize: fontSizeXXl, fontWeight: FontWeight.bold);
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
        child: Padding(
          padding: const EdgeInsets.only(
              top: defualtPaddingMedium,
              left: defualtPaddingMedium,
              right: defualtPaddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'บริการ: ',
                                style: _textStyleBig,
                              ),
                              Text(
                                'แบตเตอรี่',
                                style: _textStyleBig,
                              ),
                            ],
                          ),
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
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset('assets/images/icon-profile2.png'),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Wt.fluke")
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon:
                          ImageIcon(AssetImage('assets/images/icon-call.png')),
                      onPressed: () {}),
                  SizedBox(
                    width: 100,
                  ),
                  IconButton(
                      icon: ImageIcon(
                          AssetImage('assets/images/icon-message.png')),
                      onPressed: () {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
