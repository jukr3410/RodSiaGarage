import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/profile_feature/widgets/buttonToEditProfile.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class EditImageGarage extends StatefulWidget {
  final Garage garage;
  EditImageGarage({Key? key, required this.garage}) : super(key: key);

  @override
  _EditImageGarageState createState() => _EditImageGarageState();
}

class _EditImageGarageState extends State<EditImageGarage> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
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
                              loadAssets();
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

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          statusBarColor: '#808080',
          actionBarColor: '#38454C',
          actionBarTitle: "เลือกรูปภาพ",
          allViewTitle: "รูปทั้งหมด",
          useDetailsView: false,
          selectCircleStrokeColor: "#FECE2F",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
}
