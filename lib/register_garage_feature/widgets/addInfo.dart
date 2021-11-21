import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_address_picker/map_address_picker.dart';
import 'package:map_address_picker/models/location_result.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/register_garage_feature/bloc/register_bloc.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/locationPicker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:map_pin_picker/map_pin_picker.dart';

import 'otp.dart';

class AddInfo extends StatefulWidget {
  Garage garage;
  AddInfo({Key? key, required this.garage}) : super(key: key);
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final _controller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneConTroller = TextEditingController();
  var confirmPass;

  Garage _garage = Garage(
      services: [],
      address:
          Address(geoLocation: GeoLocation(lat: "", long: ""), addressDesc: ""),
      images: [],
      typeCarRepairs: [],
      logoImage: "",
      id: "",
      name: "",
      phone: "",
      email: "",
      otp: "",
      password: "",
      validatePhone: true,
      openingHour: OpeningHour(
          mo: Day(open: "", close: ""),
          tu: Day(open: "", close: ""),
          we: Day(open: "", close: ""),
          th: Day(open: "", close: ""),
          fr: Day(open: "", close: ""),
          sa: Day(open: "", close: ""),
          su: Day(open: "", close: "")));

  late RegisterBloc _registerBloc;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(31.2060916, 29.9187),
    zoom: 14.4746,
  );

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _garage = widget.garage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            navigateToLogin();
            showTopSnackBar(
                context, CustomSnackBar.success(message: "สมัครสมาชิกสำเร็จ"));
          } else if (state is RegisterError) {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: mError,
              ),
            );
          }
        },
        builder: (context, state) {
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
                backgroundColor: primaryColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: textColorBlack),
                  onPressed: () => navigateBackToOtp(),
                ),
              ),
              backgroundColor: primaryColor,
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: borderRadiusHight,
                          boxShadow: [boxShadow]),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(25),
                      //   child: Image.asset(
                      //     'assets/launcher/ic_launcher.png',
                      //     height: 120,
                      //   ),
                      // ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      child: Text(
                                        "ระบุข้อมูล",
                                        style: TextStyle(
                                            color: textColorBlack,
                                            fontSize: fontSizeXXl),
                                      ),
                                    ),
                                    TextFormField(
                                        // maxLength: 25,
                                        onChanged: (value) =>
                                            {_garage.name = value},
                                        keyboardType: TextInputType.name,
                                        autofocus: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: textColorBlack,
                                            fontSize: 15),
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
                                          hintText: "ชื่อ",
                                          hintStyle: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "โปรระบุชื่อ"),
                                          MinLengthValidator(1,
                                              errorText: "โปรระบุชื่อ"),
                                        ])),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        // maxLength: 25,
                                        onChanged: (value) => {
                                              value.isEmpty
                                                  ? _garage.email = ""
                                                  : _garage.email = value
                                            },
                                        keyboardType: TextInputType.name,
                                        autofocus: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: textColorBlack,
                                            fontSize: 15),
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
                                          hintText: tEmail + " (ไม่จำเป็น)",
                                          hintStyle: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                        ),
                                        validator: MultiValidator([
                                          EmailValidator(
                                              errorText:
                                                  'โปรดระบุอีเมลให้ถูกต้อง')
                                          // RequiredValidator(errorText: ""),
                                          // MinLengthValidator(14,
                                          //     errorText:
                                          //         "Phone should be atleast 10 number."),
                                        ])),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        // maxLength: 25,
                                        onChanged: (value) =>
                                            {_garage.password = value},
                                        keyboardType: TextInputType.name,
                                        autofocus: true,
                                        obscureText: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: textColorBlack,
                                            fontSize: 15),
                                        inputFormatters: [
                                          //MaskedInputFormatter('(###)-###-####')
                                        ],
                                        decoration: InputDecoration(
                                          // icon: Icon(Icons.phone_android),
                                          filled: true,
                                          prefixIcon: Icon(
                                            Icons.security_rounded,
                                            color: textColorBlack,
                                          ),
                                          fillColor: Colors.white,
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(
                                              borderRadius: borderRadiusMedium,
                                              borderSide: BorderSide.none),
                                          hintText: tPasswordThai,
                                          hintStyle: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                        ),
                                        validator: (String? value) {
                                          confirmPass = value;
                                          if (value!.isEmpty) {
                                            return "โปรดระบุรหัสผ่าน";
                                          } else if (value.length < 8) {
                                            return "โปรดระบุรหัส 8 ตัวขึ้นไป";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        // maxLength: 25,
                                        keyboardType: TextInputType.name,
                                        autofocus: true,
                                        obscureText: true,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: textColorBlack,
                                            fontSize: 15),
                                        inputFormatters: [
                                          //MaskedInputFormatter('(###)-###-####')
                                        ],
                                        decoration: InputDecoration(
                                          // icon: Icon(Icons.phone_android),
                                          filled: true,
                                          prefixIcon: Icon(
                                            Icons.security_rounded,
                                            color: textColorBlack,
                                          ),
                                          fillColor: Colors.white,
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(
                                              borderRadius: borderRadiusMedium,
                                              borderSide: BorderSide.none),
                                          hintText: tConfirmPassword,
                                          hintStyle: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "โปรดระบุรหัสผ่าน";
                                          } else if (value.length < 8) {
                                            return "โปรดระบุรหัส 8 ตัวขึ้นไป";
                                          } else if (value != confirmPass) {
                                            return "โปรดระบุรหัสผ่านให้ตรงกัน";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // TextFormField(
                                    //     // maxLength: 25,
                                    //     maxLines: 1,
                                    //     keyboardType: TextInputType.text,
                                    //     autofocus: true,
                                    //     obscureText: true,
                                    //     textAlign: TextAlign.start,
                                    //     style: TextStyle(
                                    //         color: textColorBlack,
                                    //         fontSize: 15),
                                    //     inputFormatters: [
                                    //       //MaskedInputFormatter('(###)-###-####')
                                    //     ],
                                    //     decoration: InputDecoration(
                                    //       contentPadding:
                                    //           EdgeInsets.all(defualtPaddingLow),
                                    //       // icon: Icon(Icons.phone_android),
                                    //       filled: true,
                                    //       prefixIcon: Icon(
                                    //         Icons.location_on,
                                    //         color: textColorBlack,
                                    //       ),
                                    //       fillColor: Colors.white,
                                    //       alignLabelWithHint: true,
                                    //       border: OutlineInputBorder(
                                    //           borderRadius: borderRadiusMedium,
                                    //           borderSide: BorderSide.none),
                                    //       hintText: tLocationThai,

                                    //       hintStyle: TextStyle(
                                    //           color: textColorBlack,
                                    //           fontSize: 15),
                                    //     ),
                                    //     validator: MultiValidator([])),

                                    Container(
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              GFButton(
                                                  onPressed: () {
                                                    navigateLocationPicker(
                                                        context);
                                                  },
                                                  text: "แผนที่",
                                                  icon: Icon(Icons.location_on),
                                                  shape: GFButtonShape.pills,
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
                                          Text(
                                            cameraPosition == null
                                                ? "กดเพื่อเลือกตำแหน่ง"
                                                : "${cameraPosition.target.latitude}\n${cameraPosition.target.longitude}",
                                            style: const TextStyle(
                                                color: textColorBlack,
                                                fontSize: fontSizeM),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      cursorColor: primaryColor,
                                      scrollPadding: EdgeInsets.only(top: 10),
                                      maxLines: 3,
                                      style: const TextStyle(
                                          color: textColorBlack,
                                          fontSize: fontSizeM),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                        labelText: 'รายละเอียดเพิ่มเติม',
                                        alignLabelWithHint: true,
                                        contentPadding:
                                            EdgeInsets.all(defualtPaddingLow),
                                        labelStyle: TextStyle(
                                            fontSize: fontSizeM,
                                            color: textColorBlack),
                                        border: OutlineInputBorder(
                                            borderRadius: borderRadiusMedium,
                                            borderSide: BorderSide.none),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  navigateToLogin();
                                }
                              },
                              style: TextButton.styleFrom(
                                elevation: 2,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(),
                                padding: EdgeInsets.only(
                                    left: 110, right: 110, top: 20, bottom: 20),
                                primary: textColorBlack,
                                backgroundColor: textColorBlack,
                                onSurface: Colors.black,
                              ),
                              child: Text(
                                tRegistration,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateLocationPicker(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPicker()),
    );

    this.cameraPosition = result;
    this._garage.address.geoLocation.lat =
        this.cameraPosition.target.latitude.toString();
    this._garage.address.geoLocation.long =
        this.cameraPosition.target.longitude.toString();
  }

  void navigateBackToOtp() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }

  void register() {
    _registerBloc.add(RegisterButtonPressed(garage: _garage));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }
}
