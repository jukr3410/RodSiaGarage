import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';

class InfoProfile extends StatefulWidget {
  final Garage garage;
  InfoProfile({Key? key, required this.garage}) : super(key: key);

  @override
  _InfoProfileState createState() => _InfoProfileState();
}

class _InfoProfileState extends State<InfoProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [boxShadow],
          borderRadius: borderRadiusMedium,
          color: bgColor),
      child: Padding(
        padding: const EdgeInsets.all(defualtPaddingLow),
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  ClipOval(
                      child: _proFileImage(widget.garage.logoImage.toString())),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.garage.name,
                  style: TextStyle(
                      fontSize: fontSizeXXl, fontWeight: FontWeight.w600),
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(tPhone + ': '),
                    Text(
                      widget.garage.phone,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(tEmailThai + ': '),
                    Text(
                      widget.garage.email,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _proFileImage(String profileImage) {
    if (profileImage == '') {
      return Image.asset(
        tImageAsset('profile-homePage'),
        width: 100,
      );
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
