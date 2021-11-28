import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/register_garage_feature/bloc/register_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ResetPassword extends StatefulWidget {
  Garage garage;
  ResetPassword({Key? key, required this.garage}) : super(key: key);
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<ResetPassword> {
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
    openingHour: OpeningHour(open: "", close: ""),
    openingDayOfWeek: OpeningDayOfWeek(
        mo: false,
        tu: false,
        we: false,
        th: false,
        fr: false,
        sa: false,
        su: false),
  );

  bool _passwordVisible = false;

  late RegisterBloc _registerBloc;
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
      if (state is ResetSuccess) {
        navigateToLogin();
        showTopSnackBar(
            context, CustomSnackBar.success(message: "รีเซ็ตรหัสผ่านสำเร็จ"));
      } else if (state is ResetError) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: mError,
          ),
        );
      }
    }, builder: (context, state) {
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: borderRadiusHight, boxShadow: [boxShadow]),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(25),
                  //   child: Image.asset(
                  //     'assets/launcher/ic_launcher.png',
                  //     height: 150,
                  //   ),
                  // ),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  child: Text(
                                    "ระบุรหัสผ่านใหม่",
                                    style: TextStyle(
                                        color: textColorBlack,
                                        fontSize: fontSizeL + 8),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    // maxLength: 25,
                                    onChanged: (value) =>
                                        {_garage.password = value},
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    autofocus: true,
                                    obscureText: !_passwordVisible,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
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
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: textColorBlack,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      fillColor: Colors.white,
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius: borderRadiusMedium,
                                          borderSide: BorderSide.none),
                                      hintText: tPassword,
                                      hintStyle: TextStyle(
                                          color: textColorBlack, fontSize: 15),
                                    ),
                                    validator: (String? value) {
                                      confirmPass = value;
                                      if (value!.isEmpty) {
                                        return "โปรดระบุรหัสผ่าน";
                                      } else if (value.length < 8) {
                                        return "โปรดระบุรหัส 8 ตัวขึ้นไป";
                                      }
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    // maxLength: 25,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    autofocus: true,
                                    obscureText: true,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textColorBlack, fontSize: 15),
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
                                          color: textColorBlack, fontSize: 15),
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
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              resetPassword();
                            }
                          },
                          style: TextButton.styleFrom(
                            shadowColor: Colors.black,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            primary: textColorBlack,
                            backgroundColor: textColorBlack,
                            onSurface: Colors.black,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  tNext,
                                  style: TextStyle(
                                      color: textColorWhite,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }));
  }

  void navigateBackToOtp() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }

  void resetPassword() {
    _registerBloc.add(ResetButtonPressed(garage: _garage));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }
}
