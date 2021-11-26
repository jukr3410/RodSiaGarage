import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/global_widgets/supportButton.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';

class HistoryInfoPage extends StatefulWidget {
  final RequestService requestService;
  const HistoryInfoPage({Key? key, required this.requestService})
      : super(key: key);

  @override
  _HistoryInfoPageState createState() => _HistoryInfoPageState();
}

class _HistoryInfoPageState extends State<HistoryInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title:
            Container(alignment: Alignment.centerRight, child: SupportButton()),
        iconTheme: IconThemeData(color: textColorBlack),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: Form(
            child: Column(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60,
                    child:
                        _proFileImage(widget.requestService.user.profileImage)),
                Text(
                  widget.requestService.user.name,
                  style: TextStyle(
                      fontSize: fontSizeXXl + 2, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.requestService.user.phone,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Text(
                  widget.requestService.user.email,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(height: 15),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'บริการที่ใช้:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "- " + widget.requestService.service.serviceType.name,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          "- " + widget.requestService.service.name,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'รถที่ใช้บริการ:',
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "- " + widget.requestService.car.brand,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.requestService.car.model,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.requestService.car.year,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        Text(
                          "- ป้ายทะเบียน: " +
                              widget.requestService.car.regisNumber,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          tMoreInfoThai,
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "- " + widget.requestService.problemDesc,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'วันที่-เวลา',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('yyyy-MMM-dd  HH:MM น.').format(
                              DateTime.parse(
                                  widget.requestService.createdAt.toString())),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ระยะทาง: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '12 กิโลเมตร',
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'สถานที่: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '23456 แขวงนู่น เขตนี่',
                          softWrap: true,
                          maxLines: 3,
                          style: TextStyle(color: Colors.grey.shade600),
                        )
                      ],
                    )),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      height: buttonHeightSmall,
                      width: buttonWidthLarge,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(tOKThai),
                        style: flatButtonStyle(primaryColor, textColorBlack),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _proFileImage(String profileImage) {
    if (profileImage == '') {
      return Image.asset(tImageAsset('profile-homePage'),
          width: 100, height: 100);
    } else {
      return CachedNetworkImage(
        imageUrl: profileImage,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      );
    }
  }
}
