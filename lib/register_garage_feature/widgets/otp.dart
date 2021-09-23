import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool _isLoadingButton = false;
  int _otpCodeLength = 4;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      _scaffoldKey.currentState!.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
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
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                // child: Text(
                //   "RodSiaApp",
                //   style: GoogleFonts.alata(
                //       textStyle: TextStyle(color: Colors.white, fontSize: 40)),
                // ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Text(
                        "ระบุ OTP",
                        style: TextStyle(
                            color: textColorBlack, fontSize: fontSizeSemiLarge),
                      ),
                    ),
                    TextFieldPin(
                      filled: true,
                      filledColor: textColorWhite,
                      codeLength: _otpCodeLength,
                      boxSize: 60,
                      filledAfterTextChange: true,
                      textStyle: TextStyle(fontSize: 35, color: Colors.white),
                      borderStyeAfterTextChange: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      borderStyle: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      onOtpCallback: (code, isAutofill) =>
                          _onOtpCallBack(code, isAutofill),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // onOtpCallback: (code, isAutofill) =>
                    //     _onOtpCallBack(code, isAutofill),
                    TextButton(
                        onPressed: () {
                          // if (_form.currentState.validate()) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => RegisterUser()));
                          // }
                          navigateToAddInfo();
                        },
                        style: TextButton.styleFrom(
                          elevation: 2,
                          shadowColor: Colors.black,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.only(
                              left: 137, right: 137, top: 20, bottom: 20),
                          primary: Colors.orange.shade100,
                          backgroundColor: textColorBlack,
                          onSurface: Colors.black,
                        ),
                        child: Text(tNext,
                            style: TextStyle(
                                color: textColorWhite,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 20,
                    ),
                    Text("ส่งอีกครั้ง",
                        style: TextStyle(
                          color: textColorBlack,
                          fontSize: fontSizeSemiLarge,
                          shadows: [
                            Shadow(
                              blurRadius: 15.0,
                              color: Colors.blueGrey,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                          fontWeight: FontWeight.normal,
                        )),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 40),
                      child: Text(
                        "By continuing, you agree to RodSiaApp’s Terms of Use and confirm that you have read our Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColorBlack,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
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

  void navigateToAddInfo() {
    Navigator.pushNamed(context, REGISTER_ROUTE);
  }

  void navigateBackToAddPhone() {
    Navigator.of(context).pop();
  }
}
