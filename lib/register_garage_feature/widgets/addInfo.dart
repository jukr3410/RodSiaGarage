import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';

import 'otp.dart';

class AddInfo extends StatefulWidget {
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
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
          backgroundColor: textColorBlack,
        ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: borderRadiusHight, boxShadow: [boxShadow]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'assets/launcher/ic_launcher.png',
                    height: 120,
                  ),
                ),
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
                                  keyboardType: TextInputType.text,
                                  autofocus: true,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: textColorBlack, fontSize: 15),
                                  inputFormatters: [
                                    //MaskedInputFormatter('(###)-###-####')
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.all(defualtPaddingLow),
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
                                    hintText: tNameGarageThai,
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
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: true,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: textColorBlack, fontSize: 15),
                                  inputFormatters: [
                                    //MaskedInputFormatter('(###)-###-####')
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.all(defualtPaddingLow),
                                    // icon: Icon(Icons.phone_android),
                                    filled: true,
                                    prefixIcon: Icon(Icons.email,
                                        color: textColorBlack),
                                    fillColor: Colors.white,
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius: borderRadiusMedium,
                                        borderSide: BorderSide.none),
                                    hintText: tEmailThai + ':',
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

                                  keyboardType: TextInputType.visiblePassword,
                                  autofocus: true,
                                  obscureText: true,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: textColorBlack, fontSize: 15),
                                  inputFormatters: [
                                    //MaskedInputFormatter('(###)-###-####')
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.all(defualtPaddingLow),
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
                                    hintText: tPasswordThai + ':',
                                    hintStyle: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please, input password."),
                                    MinLengthValidator(14,
                                        errorText:
                                            "Phone should be atleast 10 number."),
                                  ])),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  // maxLength: 25,
                                  maxLines: 1,
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
                                    contentPadding:
                                        EdgeInsets.all(defualtPaddingLow),
                                    // icon: Icon(Icons.phone_android),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: textColorBlack,
                                    ),
                                    fillColor: Colors.white,
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius: borderRadiusMedium,
                                        borderSide: BorderSide.none),
                                    hintText: tLocationThai,

                                    hintStyle: TextStyle(
                                        color: textColorBlack, fontSize: 15),
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please, input password."),
                                    MinLengthValidator(14,
                                        errorText:
                                            "Phone should be atleast 10 number."),
                                  ])),
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
                                    fontSize: fontSizeLow),
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
                                      fontSize: fontSizeLow,
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
  }

  void navigateBackToOtp() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, LOGIN_ROUTE);
  }
}
