import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rodsiagarage/constants.dart';

class InfoAddress extends StatefulWidget {
  InfoAddress({Key? key}) : super(key: key);

  @override
  _InfoAddressState createState() => _InfoAddressState();
}

class _InfoAddressState extends State<InfoAddress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: defualtPaddingMedium, right: defualtPaddingMedium),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tLocationThai,
              style: TextStyle(
                  fontSize: fontSizeMedium, fontWeight: FontWeight.w600),
            ),
            Text('123/456 ถนนพระราม2 แขวง เขต กทรุงเทพ 10150'),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                child: CachedNetworkImage(
                  imageUrl: 'https://i.stack.imgur.com/chfhv.png',
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: textColorBlack,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // Image.network(
                //     'https://i.stack.imgur.com/chfhv.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
