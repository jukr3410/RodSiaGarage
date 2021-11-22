import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/profile_feature/bloc/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final Garage garage;
  EditProfile({Key? key, required this.garage}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  GlobalKey<FormState> _formPassword = GlobalKey<FormState>();
  final _nameConTroller = TextEditingController();
  final _emailConTroller = TextEditingController();

  late ProfileBloc _profileBloc;
  String name = '';
  String email = '';
  String imageProfile = '';
  bool addImageProfile = false;

  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = photo;
      addImageProfile = true;
    });
  }

  late XFile? _image;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);

    super.initState();
  }

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
        appBar: AppBar(
          centerTitle: true,
          title: Text('แก้ไขข้อมูล'),
          backgroundColor: textColorBlack,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: bgColor),
            onPressed: () => navigateBack(),
          ),
        ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              navigatorToProfilePage(widget.garage);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 80,
                        child: ClipOval(
                            child: _proFileImage(
                                widget.garage.logoImage.toString())),
                      ),
                      Positioned(
                          bottom: 15,
                          right: 25,
                          child: Container(
                            height: 35,
                            width: 35,
                            child: FloatingActionButton(
                              backgroundColor: textColorBlack,
                              mini: true,
                              onPressed: getImage,
                              tooltip: 'Pick Image',
                              child: new Icon(
                                Icons.add_a_photo,
                                size: 20,
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Form(
                              key: _form,
                              child: Column(
                                children: [
                                  TextFormField(
                                    onChanged: (String value) {
                                      name = value;
                                      logger.d('name: ' + _nameConTroller.text);
                                    },
                                    controller: _nameConTroller,
                                    keyboardType: TextInputType.name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                    inputFormatters: [
                                      //MaskedInputFormatter('(###)-###-####')
                                    ],
                                    decoration: InputDecoration(
                                      // icon: Icon(Icons.phone_android),
                                      filled: true,
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: textColorBlack,
                                      ),

                                      border: OutlineInputBorder(
                                          borderRadius: borderRadiusMedium,
                                          borderSide: BorderSide.none),
                                      hintText: widget.garage.name,
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    // validator: MultiValidator([
                                    //   RequiredValidator(
                                    //       errorText: "โปรดใส่ชื่อใหม่ของคุณ"),
                                    // ])
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    // maxLength: 25,
                                    onChanged: (String value) {
                                      email = value;
                                      logger
                                          .d('email: ' + _emailConTroller.text);
                                    },
                                    controller: _emailConTroller,
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                    inputFormatters: [
                                      //MaskedInputFormatter('(###)-###-####')
                                    ],
                                    decoration: InputDecoration(
                                      // icon: Icon(Icons.phone_android),
                                      filled: true,
                                      prefixIcon: Icon(Icons.email,
                                          color: textColorBlack),
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius: borderRadiusMedium,
                                          borderSide: BorderSide.none),
                                      hintText: widget.garage.email,
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    // validator: MultiValidator([
                                    //   RequiredValidator(
                                    //       errorText: "โปรดใส่อีเมลใหม่ของคุณ"),
                                    // ])
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GFButton(
                                      onPressed: () {
                                        _navigatorToEditPassword();
                                      },
                                      child: Text('เปลี่ยนรหัสผ่าน'),
                                      type: GFButtonType.transparent,
                                      color: textColorBlack,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              if (name == '' && email == '') {
                                _navigateAndDisplayEditError(context);
                              } else {
                                _navigateAndDisplayEdit(context);
                              }
                            },
                            style: TextButton.styleFrom(
                              fixedSize:
                                  Size(buttonWidthMedium, buttonHeightMedium),
                              elevation: 2,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(),
                              primary: textColorBlack,
                              backgroundColor: textColorBlack,
                              onSurface: Colors.black,
                            ),
                            child: Text(
                              'แก้ไขข้อมูล',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                        GFButton(
                          onPressed: () {
                            navigateBack();
                          },
                          child: Text(
                            tCancleThai,
                            style: TextStyle(
                                color: textColorBlack,
                                fontFamily: 'Kanit',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          type: GFButtonType.transparent,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateAndDisplayEdit(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopupYesNo(
              title: 'คุณต้องการอัพเดตข้อมูลใช้ไหม',
            ));
    if (result == 'Ok') {
      if (name != '') {
        widget.garage.name = name;
      }
      if (email != '') {
        widget.garage.email = email;
      }
      logger.d(widget.garage.toJson());
      _profileBloc.add(GarageUpdateNoPassword(widget.garage));
    }
  }

  void _navigatorToEditPassword() {
    Navigator.pushNamed(context, EDIT_PASSWOED_ROUTE, arguments: widget.garage);
  }

  void _navigateAndDisplayEditError(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopupYesNo(
              title: 'คุณต้องใล่ข้อมูล',
            ));
    if (result == 'Ok') {}
  }

  void _navigateToErrorPassword(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _AlertErrorPinPassword());
    if (result == 'Ok') {
      _navigateAndDisplayEdit(context);
    }
  }

  Widget _AlertErrorPinPassword() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: cardWidthLow,
          decoration: BoxDecoration(
            borderRadius: borderRadiusMedium,
            boxShadow: [boxShadow],
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(defualtPaddingLow),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'รหัสผ่านผิด!, โปรดลองใหม่อีกครั้ง: ',
                  style: TextStyle(
                      fontSize: fontSizeL,
                      color: textColorBlack,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kanit'),
                ),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Container(
                    height: buttonHeightSmall,
                    width: buttonWidthSmall,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Ok');
                      },
                      child: Text(tOKThai),
                      style: flatButtonStyle(primaryColor, textColorBlack),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateBack() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, LOGIN_ROUTE);
  }

  void navigatorToProfilePage(Garage garage) {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: garage);
  }

  _proFileImage(String profileImage) {
    if (profileImage == '' && addImageProfile == false) {
      return Image.asset(
        tImageAsset('profile'),
        fit: BoxFit.cover,
        width: 130,
        height: 130,
      );
    } else if (addImageProfile == true) {
      return Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
        width: 130,
        height: 130,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: profileImage,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: 120,
        width: 120,
      );
    }
  }
}
