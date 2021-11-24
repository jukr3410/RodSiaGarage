import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/profile_feature/bloc/profile_bloc.dart';
import 'package:rodsiagarage/profile_feature/widgets/buttonToEditProfile.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';

class EditImageGarage extends StatefulWidget {
  final Garage garage;
  EditImageGarage({Key? key, required this.garage}) : super(key: key);

  @override
  _EditImageGarageState createState() => _EditImageGarageState();
}

class _EditImageGarageState extends State<EditImageGarage> {
  List<File> imageResult = <File>[];
  List<ImageGarage> imagesGarage = <ImageGarage>[];
  late ProfileBloc _profileBloc;
  Garage garage = gargeMockup;
  final ImagePicker _picker = ImagePicker();
  late List<XFile>? _image;
  Future getImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    setState(() {
      if (images != null) {
        _image = images;
        for (var item in _image!) {
          _profileBloc.add(UploadImage(image: File(item.path)));
        }
      }
    });
  }

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    garage = widget.garage;
    imagesGarage = widget.garage.images!;

    return Container(
      decoration: BoxDecoration(color: bgColor
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //   Colors.yellow.shade800,
          //   Colors.yellow.shade400,
          //   Colors.yellow.shade50
          // ])
          ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: bgColor),
              onPressed: () => _navigatorToProfilePage(garage),
            ),
            centerTitle: true,
            title: Text('แก้ไขรูปภาพ'),
            backgroundColor: textColorBlack,
          ),
          body: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is UploadImageSuccess) {
                _profileBloc.add(ProfileLoadFormPhone());
              }
              if (state is GarageLoadSuccess) {
                imagesGarage = state.garage.images!;
                garage = state.garage;
                logger.d(imagesGarage.length);
                // _navigatorToProfilePage(garage);
              }
              if (state is ProfileUpdated) {
                _profileBloc.add(ProfileLoadFormPhone());
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(defualtPaddingLow),
                child: Column(
                  children: [
                    addImageForReq(context),
                    SizedBox(
                      height: 10,
                    ),
                    _showButtonAddImage()
                  ],
                ),
              ));
            },
          )),
    );
  }

  Widget addImageForReq(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      children: List.generate(imagesGarage.length, (index) {
        String image = imagesGarage[index].image;
        print(image);
        return _showImages(context, image, index);
      }),
    );
  }

  _showButtonAddImage() {
    if (widget.garage.images!.length <= 15) {
      return Align(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: textColorBlack),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    getImage();
                  },
                  color: primaryColor,
                )),
            SizedBox(
              height: 5,
            ),
            Text('เพิ่มรูปภาพ')
          ],
        ),
      );
    } else {
      return Text('ไม่สามารถเพิ่มรูปได้แล้ว');
    }
  }

  _showImages(BuildContext context, String image, int index) {
    return Column(
      children: [
        Stack(
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
            Positioned(
                right: -10,
                top: -10,
                child: IconButton(
                  tooltip: 'Pick Image',
                  onPressed: () {
                    _navigateAndDisplayEditError(context, index);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: bgColor,
                  ),
                )),
          ],
        ),
        Text('รูปที่: ' + (index + 1).toString())
      ],
    );
  }

  void _navigateAndDisplayEditError(BuildContext context, int index) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopupYesNo(
              title: 'คุณต้องการลบรูปนี้ใช้ไหม',
            ));
    if (result == 'Ok') {
      logger.d(garage.images!.length - 1);
      logger.d('index remove' + index.toString());
      garage.images!.removeAt(index);
      // imagesGarage.removeAt(index);
      _profileBloc.add(GarageUpdateNoPassword(garage: garage));
    }
  }

  _navigatorToProfilePage(Garage garage) {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: garage);
  }
}
