import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_model.dart';

class ShowInfoService extends StatelessWidget {
  final Service service;
  const ShowInfoService({Key? key, required this.service}) : super(key: key);

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
          padding: const EdgeInsets.only(
              top: defualtPaddingLow,
              bottom: defualtPaddingLow,
              left: defualtPaddingMedium,
              right: defualtPaddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                tImageAsset(service.serviceType.name),
                width: 65,
                height: 65,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                service.name,
                style: TextStyle(
                    fontSize: fontSizeXl, fontWeight: FontWeight.w600),
                softWrap: true,
                maxLines: 1,
              ),
              // Text(
              //   'ประเภท: ',
              //   style: TextStyle(color: Colors.grey.shade600),
              // ),
              Text(
                'ประเภท: '+service.serviceType.name,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                'รายละเอียด: ',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Flexible(
                child: Text(
                  '- '+service.description!,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: buttonHeightSmall - 10,
                    width: buttonWidthSmall - 20,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(tOKThai),
                      style: flatButtonStyle(primaryColor, textColorBlack),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
