import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/global_widgets/buttonAcceptAndDecline.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MoreInfoRequestPage extends StatefulWidget {
  final RequestService req;
  MoreInfoRequestPage({Key? key, required this.req}) : super(key: key);

  @override
  _MoreInfoRequestPageState createState() => _MoreInfoRequestPageState();
}

class _MoreInfoRequestPageState extends State<MoreInfoRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ข้อมูลขอใช้บริการ',
            style: TextStyle(color: textColorBlack),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(defualtPaddingLow),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadiusMedium,
                    boxShadow: [boxShadow],
                    color: bgColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(defualtPaddingMedium),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'บริการ: ',
                                    style: TextStyle(
                                        fontSize: fontSizeXl,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.req.service.name,
                                    style: TextStyle(
                                        fontSize: fontSizeXl,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset('car'),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('รุ่น: '),
                                          Text(
                                            widget.req.car.brand,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            widget.req.car.model,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            widget.req.car.year,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('ป้ายทะเบียน: '),
                                          Text(
                                            widget.req.car.regisNumber,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('ชนิด: '),
                                          Text(
                                            widget.req.car.type,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset('distance'),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '~ 12 กิโลเมตร.',
                                    softWrap: true,
                                    style: _textStyleSmall,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset('location2'),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      widget.req.addressUser,
                                      softWrap: true,
                                      style: _textStyleSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset('desc'),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      widget.req.problemDesc,
                                      softWrap: true,
                                      style: _textStyleSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: textColorBlack),
                                child: IconButton(
                                  icon: Icon(Icons.call),
                                  onPressed: () {
                                    UrlLauncher.launch(
                                        'tel://${widget.req.user.phone}');
                                  },
                                  color: primaryColor,
                                )),
                            Text(
                              'โทรสอบถาม',
                              style: TextStyle(fontSize: fontSizeS),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
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
                GFButton(
                  onPressed: () {},
                  text: tDeclineThai,
                  textColor: textColorBlack,
                  type: GFButtonType.transparent,
                )
              ],
            )
          ],
        ));
  }

  TextStyle _textStyleSmall = TextStyle(
    fontSize: fontSizeM,
  );
}
