import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/home_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/profile_feature/bloc/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/locationPicker.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:weekday_selector/weekday_selector.dart';

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
  bool deleteImageProfile = false;
  Garage _garage = gargeMockup;

  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
        addImageProfile = true;
      });
    }
  }

  OpeningDayOfWeek _openingDayOfWeek = OpeningDayOfWeek(
      mo: false,
      tu: false,
      we: false,
      th: false,
      fr: false,
      sa: false,
      su: false);

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(13.7245601, 100.4930247),
    zoom: 14.4746,
  );

  String address = '';
  String openingTime = '';
  TimeRange? timeRange;

  // We start with all days selected.
  final values = List.filled(7, false);

  File? _image;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageProfile = widget.garage.logoImage.toString();
    logger.d(imageProfile);
    _garage = widget.garage;
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
              onPressed: () => navigatorToProfilePage(widget.garage)),
        ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              _profileBloc.add(ProfileLoadFormPhone());
            }
            if (state is GarageLoadSuccess) {
              navigatorToProfilePage(state.garage);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _showImageProfile(imageProfile),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
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
                                        logger
                                            .d('name: ' + _nameConTroller.text);
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
                                            color: textColorBlack,
                                            fontSize: 15),
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
                                        logger.d(
                                            'email: ' + _emailConTroller.text);
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
                                            color: textColorBlack,
                                            fontSize: 15),
                                      ),
                                      // validator: MultiValidator([
                                      //   RequiredValidator(
                                      //       errorText: "โปรดใส่อีเมลใหม่ของคุณ"),
                                      // ])
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GFButton(
                                                shape: GFButtonShape.pills,
                                                onPressed: () {
                                                  navigateLocationPicker(
                                                      context);
                                                },
                                                text: "แผนที่",
                                                icon: Icon(
                                                  Icons.location_on,
                                                  color: textColorBlack,
                                                ),
                                                color: textColorWhite,
                                                textColor: textColorBlack),
                                          ],
                                        ),
                                        // Text(
                                        //   locationResult == null
                                        //       ? "กดเพื่อเลือกตำแหน่ง"
                                        //       : "${locationResult!.latLng!.latitude}\n${locationResult!.latLng!.longitude}",
                                        //   style: const TextStyle(
                                        //       color: textColorBlack,
                                        //       fontSize: fontSizeM),
                                        // ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 230,
                                          child: Text(
                                              address.isEmpty
                                                  ? widget.garage.address
                                                      .addressDesc
                                                  : address,
                                              style: const TextStyle(
                                                  color: textColorBlack,
                                                  fontSize: fontSizeM),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2),
                                        )
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              GFButton(
                                                  onPressed: () async {
                                                    TimeRange result =
                                                        await showTimeRangePicker(
                                                      context: context,
                                                    );

                                                    logger.d(
                                                        "opening time: ${result}");
                                                    timeRange = result;
                                                    setOpeningTime();
                                                  },
                                                  text: "เวลา",
                                                  icon: Icon(Icons.av_timer),
                                                  shape: GFButtonShape.pills,
                                                  color: textColorWhite,
                                                  textColor: textColorBlack),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              openingTime.isEmpty
                                                  ? "เปิด: ${widget.garage.openingHour!.open.toString()} - ${widget.garage.openingHour!.close.toString()} น."
                                                  : openingTime,
                                              style: const TextStyle(
                                                  color: textColorBlack,
                                                  fontSize: fontSizeM),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2)
                                        ],
                                      ),
                                    ),
                                    WeekdaySelector(
                                      firstDayOfWeek: DateTime.sunday,
                                      shortWeekdays: [
                                        'Sun',
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat',
                                      ],
                                      selectedFillColor: textColorBlack,
                                      onChanged: (int day) {
                                        setState(() {
                                          // Use module % 7 as Sunday's index in the array is 0 and
                                          // DateTime.sunday constant integer value is 7.
                                          final index = day % 7;
                                          // We "flip" the value in this example, but you may also
                                          // perform validation, a DB write, an HTTP call or anything
                                          // else before you actually flip the value,
                                          // it's up to your app's needs.
                                          values[index] = !values[index];
                                        });
                                        logger
                                            .d("day: ${this.values.toList()}");
                                        setTimeOfDay();
                                      },
                                      values: values,
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
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                if (name == '' &&
                                    email == '' &&
                                    addImageProfile == false &&
                                    address == '' &&
                                    openingTime == '' &&
                                    _openingDayOfWeek.we == false &&
                                    _openingDayOfWeek.tu == false &&
                                    _openingDayOfWeek.th == false &&
                                    _openingDayOfWeek.su == false &&
                                    _openingDayOfWeek.sa == false &&
                                    _openingDayOfWeek.mo == false &&
                                    _openingDayOfWeek.fr == false &&
                                    deleteImageProfile == false) {
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
        _garage.name = name;
      }
      if (email != '') {
        widget.garage.email = email;
      }
      if (address != '') {
        _garage.address.addressDesc = address;
        _garage.address.geoLocation.lat =
            this.cameraPosition.target.latitude.toString();
        _garage.address.geoLocation.long =
            this.cameraPosition.target.longitude.toString();
      }
      if (openingTime != '') {
        _garage.openingHour!.open =
            '${timeRange!.startTime.hour}.${timeRange!.startTime.minute}';
        _garage.openingHour!.close =
            '${timeRange!.endTime.hour}.${timeRange!.endTime.minute}';
      }
      if (_openingDayOfWeek.we == false &&
          _openingDayOfWeek.tu == false &&
          _openingDayOfWeek.th == false &&
          _openingDayOfWeek.su == false &&
          _openingDayOfWeek.sa == false &&
          _openingDayOfWeek.mo == false &&
          _openingDayOfWeek.fr == false) {
      } else {
        _garage.openingDayOfWeek = _openingDayOfWeek;
      }
      if (deleteImageProfile == true) {
        _garage.logoImage = '';
      }
      logger.d(_garage.toJson());
      _profileBloc.add(GarageUpdateNoPassword(
          garage: _garage,
          image: deleteImageProfile == true || addImageProfile == false
              ? null
              : _image!));
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
    if (profileImage == '' && addImageProfile == false ||
        deleteImageProfile == true && addImageProfile == false) {
      return Image.asset(
        tImageAsset('profile-homePage'),
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      );
    } else if (addImageProfile == true) {
      return Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
        width: 120,
        height: 120,
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

  _showImageProfile(String profileImage) {
    if (profileImage == '' && addImageProfile == false ||
        deleteImageProfile == true && addImageProfile == false) {
      return Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 80,
            child: ClipOval(child: _proFileImage(profileImage)),
          ),
          Positioned(
              bottom: 20,
              right: 30,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: textColorBlack),
                child: Align(
                  alignment: Alignment.center,
                  child: new IconButton(
                      onPressed: getImage,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: bgColor,
                        size: 15,
                      )),
                ),
              )),
        ],
      );
    } else {
      return Column(
        children: [
          Stack(
            children: [
              ClipOval(child: _proFileImage(profileImage)),
              Positioned(
                  right: 10,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: redStatus),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            addImageProfile = false;
                            deleteImageProfile = true;
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: bgColor,
                          size: 15,
                        )),
                  )),
            ],
          ),
          GFButton(
            onPressed: getImage,
            child: Text('เปลี่ยนรูปภาพ'),
            textStyle: TextStyle(color: textColorBlack, fontSize: fontSizeM),
            type: GFButtonType.transparent,
          )
        ],
      );
    }
  }

  void setOpeningTime() {
    if (timeRange != null) {
      logger.d(
          "start: ${timeRange!.startTime.hour}.${timeRange!.startTime.minute} - ${timeRange!.endTime.hour}.${timeRange!.endTime.minute} น.");
      setState(() {
        this.openingTime =
            "เปิด: ${timeRange!.startTime.hour}.${timeRange!.startTime.minute} - ${timeRange!.endTime.hour}.${timeRange!.endTime.minute} น.";
      });
    }
  }

  void setTimeOfDay() {
    _openingDayOfWeek.su = values[0];
    _openingDayOfWeek.mo = values[1];
    _openingDayOfWeek.tu = values[2];
    _openingDayOfWeek.we = values[3];
    _openingDayOfWeek.th = values[4];
    _openingDayOfWeek.fr = values[5];
    _openingDayOfWeek.sa = values[6];
    logger.d("openingDayOfWeek: ${_openingDayOfWeek.toJson()}");
  }

  void navigateLocationPicker(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPicker()),
    );
    setState(() {
      this.cameraPosition = result['cameraPosition'];
    });
    setState(() {
      this.address = result['address'];
    });
  }
}
