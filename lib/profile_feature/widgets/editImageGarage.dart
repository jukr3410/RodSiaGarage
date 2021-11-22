import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/profile_feature/widgets/buttonToEditProfile.dart';

class EditImageGarage extends StatefulWidget {
  final Garage garage;
  EditImageGarage({Key? key, required this.garage}) : super(key: key);

  @override
  _EditImageGarageState createState() => _EditImageGarageState();
}

class _EditImageGarageState extends State<EditImageGarage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.yellow.shade800,
            Colors.yellow.shade400,
            Colors.yellow.shade50
          ])),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text('แก้ไขรูปภาพ'),
            backgroundColor: textColorBlack,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(defualtPaddingLow),
            child: Column(
              children: [
                addImageForReq(),
                SizedBox(
                  height: 10,
                ),
                Align(
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: textColorBlack),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // navigatorToEditImages();
                            },
                            color: primaryColor,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text('เพิ่มรูปภาพ')
                    ],
                  ),
                )
              ],
            ),
          ))),
    );
  }

  Widget addImageForReq() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      children: List.generate(widget.garage.images!.length, (index) {
        String image = widget.garage.images![index].image;
        print(image);
        if (index == widget.garage.images!.length + 1) {}
        return _showImages(image, index);
      }),
    );
  }

  _showImages(String image, int index) {
    return GestureDetector(
      child: Column(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: image,
            width: 95,
            height: 95,
            placeholder: (context, url) => CircularProgressIndicator(
              color: textColorBlack,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text('รูปที่: ' + (index + 1).toString())
        ],
      ),
    );
  }
}
