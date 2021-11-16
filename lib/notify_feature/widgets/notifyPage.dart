import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/main.dart';

class NotifyPage extends StatefulWidget {
  NotifyPage({Key? key}) : super(key: key);

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: primaryColor,
        //   title: Text(
        //     'การแจ้งเตือน',
        //     style: TextStyle(color: textColorBlack, fontSize: fontSizeXXl),
        //   ),
        //   iconTheme: IconThemeData(color: textColorBlack),
        //   centerTitle: true,
        // ),
        body: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: mockupNotify.length,
            itemBuilder: (context, index) {
              return cardNotify(mockupNotify[index]);
            }));
  }

  Widget cardNotify(NotifyInfo notifyInfo) {
    return GestureDetector(
      child: Card(
        // shape: RoundedRectangleBorder(borderRadius: borderRadiusMedium),
        elevation: 2,
        margin: new EdgeInsets.symmetric(
            horizontal: defualtPaddingLow - 2, vertical: defualtPaddingLow - 7),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                tImageAsset(notifyInfo.typeNotify),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defualtPaddingMedium,
                  // vertical: 10,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        notifyInfo.title,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: new TextStyle(
                            fontSize: fontSizeL - 1,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack),
                      ),
                      Text(
                        notifyInfo.desc[0],
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            fontSize: fontSizeM - 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, NOTIFY_ROUTE, arguments: notifyInfo);
      },
    );
  }
}

class NotifyInfo {
  final String typeNotify;
  final String title;
  final List<String> desc;
  final String image;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> condition;

  NotifyInfo(
      {required this.desc,
      required this.typeNotify,
      required this.condition,
      required this.image,
      required this.title,
      required this.endDate,
      required this.startDate});
}
