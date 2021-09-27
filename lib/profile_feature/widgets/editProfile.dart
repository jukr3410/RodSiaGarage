import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';

class EditProfile extends StatefulWidget {
  Garage garage;
  EditProfile({Key? key, required this.garage}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneConTroller = TextEditingController();

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
        body: Center(
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
                      child: Image.asset(
                        tImageAsset('profile-homePage'),
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 7,
                      right: 18,
                      child: Container(
                        height: 35,
                        width: 35,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        decoration: BoxDecoration(
                            color: textColorBlack,
                            borderRadius: borderRadiusHight),
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
                                  // maxLength: 25,
                                  keyboardType: TextInputType.name,
                                  autofocus: true,
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
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            "Please, input phone number."),
                                    MinLengthValidator(14,
                                        errorText:
                                            "Phone should be atleast 10 number."),
                                  ])),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  // maxLength: 25,
                                  keyboardType: TextInputType.name,
                                  autofocus: true,
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
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            "Please, input phone number."),
                                    MinLengthValidator(14,
                                        errorText:
                                            "Phone should be atleast 10 number."),
                                  ])),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // TextFormField(
                              //     // maxLength: 25,
                              //     keyboardType: TextInputType.name,
                              //     autofocus: true,
                              //     obscureText: true,
                              //     textAlign: TextAlign.start,
                              //     style: TextStyle(
                              //         color: textColorBlack, fontSize: 15),
                              //     inputFormatters: [
                              //       //MaskedInputFormatter('(###)-###-####')
                              //     ],
                              //     decoration: InputDecoration(
                              //       // icon: Icon(Icons.phone_android),
                              //       filled: true,
                              //       prefixIcon: Icon(
                              //         Icons.security_rounded,
                              //         color: textColorBlack,
                              //       ),
                              //       fillColor: Colors.white,
                              //       alignLabelWithHint: true,
                              //       border: OutlineInputBorder(
                              //           borderRadius: borderRadiusMedium,
                              //           borderSide: BorderSide.none),
                              //       hintText: 'รหัสผ่านเก่า',
                              //       hintStyle: TextStyle(
                              //           color: textColorBlack, fontSize: 15),
                              //     ),
                              //     validator: MultiValidator([
                              //       RequiredValidator(
                              //           errorText: "Please, input password."),
                              //       MinLengthValidator(14,
                              //           errorText:
                              //               "Phone should be atleast 10 number."),
                              //     ])),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // TextFormField(
                              //     // maxLength: 25,
                              //     keyboardType: TextInputType.name,
                              //     autofocus: true,
                              //     obscureText: true,
                              //     textAlign: TextAlign.start,
                              //     style: TextStyle(
                              //         color: textColorBlack, fontSize: 15),
                              //     inputFormatters: [
                              //       //MaskedInputFormatter('(###)-###-####')
                              //     ],
                              //     decoration: InputDecoration(
                              //       // icon: Icon(Icons.phone_android),
                              //       filled: true,
                              //       prefixIcon: Icon(
                              //         Icons.security_rounded,
                              //         color: textColorBlack,
                              //       ),
                              //       fillColor: Colors.white,
                              //       alignLabelWithHint: true,
                              //       border: OutlineInputBorder(
                              //           borderRadius: borderRadiusMedium,
                              //           borderSide: BorderSide.none),
                              //       hintText: 'รหัสผ่านใหม่',
                              //       hintStyle: TextStyle(
                              //           color: textColorBlack, fontSize: 15),
                              //     ),
                              //     validator: MultiValidator([
                              //       RequiredValidator(
                              //           errorText: "Please, input password."),
                              //       MinLengthValidator(14,
                              //           errorText:
                              //               "Phone should be atleast 10 number."),
                              //     ])),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            navigateToLogin();
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
      ),
    );
  }

  void navigateBack() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, LOGIN_ROUTE);
  }
}
