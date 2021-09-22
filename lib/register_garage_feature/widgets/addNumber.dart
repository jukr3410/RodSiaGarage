import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rodsiagarage/constants.dart';

class AddNumber extends StatefulWidget {
  @override
  _AddNumberState createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

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
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: borderRadiusHight,
                        boxShadow: [boxShadow]),
                    child: ClipRRect(
                      borderRadius: borderRadiusMedium,
                      child: Image.asset(
                        'assets/launcher/ic_launcher.png',
                        height: 200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    // child: Text(
                    //   "RodSiaApp",
                    //   style: GoogleFonts.alata(
                    //       textStyle:
                    //           TextStyle(color: Colors.white, fontSize: 40)),
                    // ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 5, horizontal: 40),
                        //   child: Text(
                        //     tPhone,
                        //     style: GoogleFonts.alata(
                        //         textStyle: TextStyle(
                        //             color: textColorBlack, fontSize: fontSizeL)),
                        //   ),
                        // ),
                        Form(
                          key: _form,
                          child: TextFormField(
                              // maxLength: 15,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textColorBlack, fontSize: 20),
                              inputFormatters: [
                                MaskedInputFormatter('###-###-####'),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  color: textColorBlack,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Enter moblie number',
                                hintStyle: TextStyle(
                                  color: textColorBlack,
                                  fontSize: 20,
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: mErrorInputPhone),
                                MinLengthValidator(1,
                                    errorText:
                                        "Phone should be atleast 10 number."),
                              ])),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              if (_form.currentState!.validate()) {
                                navigateToOtp();
                              }
                            },
                            style: TextButton.styleFrom(
                              elevation: 2,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(),
                              padding: EdgeInsets.only(
                                  left: 137, right: 137, top: 20, bottom: 20),
                              primary: textColorBlack,
                              backgroundColor: textColorBlack,
                              onSurface: Colors.black,
                            ),
                            child: Text(
                              tNext,
                              style: TextStyle(
                                  color: textColorWhite,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 40),
                          child: Text(
                            "By continuing, you agree to RodSiaApp’s Terms of Use   and confirm that you have read our Privacy Policy",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColorBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToOtp() {
    Navigator.pushNamed(context, OTP_ROUTE);
  }

  void navigateBackToAddPhone() {
    Navigator.of(context).pop();
  }
}
