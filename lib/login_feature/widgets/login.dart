import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rodsiagarage/login_feature/bloc/login_bloc.dart';
import 'package:rodsiagarage/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: '${state.error}',
            ),
          );
        } else if (state is LoginLoading) {
          Fluttertoast.showToast(
              msg: "Loading...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: textColorBlack,
              fontSize: 16.0);
        } else if (state is LoginSuccess) {
          navigateToMain();
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
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: new EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        borderRadius: borderRadiusHight,
                        boxShadow: [boxShadow]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/launcher/ic_launcher.png',
                        height: 150,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    // child: Text(
                    //   tRegistration,
                    //   style: GoogleFonts.alata(
                    //       textStyle: TextStyle(color: textColorBlack, fontSize: 30)),
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
                                  TextFormField(
                                      // maxLength: 25,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      autofocus: true,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.alata(
                                          textStyle: TextStyle(
                                              color: textColorBlack,
                                              fontSize: fontSizeXl)),
                                      // inputFormatters: [
                                      //   MaskedInputFormatter('###-###-####')
                                      // ],
                                      decoration: InputDecoration(
                                        // icon: Icon(Icons.phone_android),
                                        filled: true,
                                        fillColor: Colors.white,
                                        alignLabelWithHint: true,
                                        prefixIcon: Icon(
                                          Icons.phone_android,
                                          color: textColorBlack,
                                        ),

                                        border: OutlineInputBorder(
                                            borderRadius: borderRadiusMedium,
                                            borderSide: BorderSide.none),
                                        hintText: tPhone,
                                        hintStyle: GoogleFonts.alata(
                                            textStyle: TextStyle(
                                                color: textColorBlack,
                                                fontSize: 15)),
                                      ),
                                      controller: phoneController,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "โปรดระบุเบอร์โทร"),
                                        MinLengthValidator(10,
                                            errorText:
                                                "โปรดระบุเบอร์ให้ครบ 10 ตัว"),
                                      ])),
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
                                      style: GoogleFonts.alata(
                                          textStyle: TextStyle(
                                              color: textColorBlack,
                                              fontSize: fontSizeXl)),
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
                                        hintText: tPassword,
                                        hintStyle: GoogleFonts.alata(
                                            textStyle: TextStyle(
                                                color: textColorBlack,
                                                fontSize: 15)),
                                      ),
                                      controller: passwordController,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "โปรดระบุรหัสผ่าน"),
                                        // MinLengthValidator(8,
                                        //     errorText:
                                        //         ""),
                                      ])),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  //navigateToMain();
                                  if (state is! LoginLoading) {
                                    _onLoginButtonPressed();
                                  } else {
                                    null;
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                elevation: 2,
                                shadowColor: Colors.black,
                                shape: StadiumBorder(),
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                primary: textColorBlack,
                                backgroundColor: textColorBlack,
                                onSurface: Colors.black,
                              ),
                              child: Text(tLogin,
                                  style: GoogleFonts.alata(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                navigateToAddNumber();
                              },
                              child: Text(
                                tRegistration,
                                style: GoogleFonts.alata(
                                    textStyle: TextStyle(
                                  color: textColorBlack,
                                  fontSize: fontSizeL,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 15.0,
                                      color: Colors.blueGrey,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  fontWeight: FontWeight.normal,
                                )),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateToResetPassword();
                              },
                              child: Text(
                                tForgetPassword + "?",
                                style: GoogleFonts.alata(
                                    textStyle: TextStyle(
                                  color: textColorBlack,
                                  fontSize: fontSizeL,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 15.0,
                                      color: Colors.blueGrey,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                  fontWeight: FontWeight.normal,
                                )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _onLoginButtonPressed() {
    logger.d(phoneController.text);
    logger.d(passwordController.text);
    _loginBloc.add(LoginButtonPressed(
      phone: phoneController.text,
      password: passwordController.text,
    ));
  }

  void navigateToAddNumber() {
    Navigator.pushNamed(context, ADD_NUMBER_ROUTE);
  }

  void navigateToMain() {
    Navigator.pushReplacementNamed(context, MAIN_ROUTE);
  }

  void navigateToResetPassword() {
    logger.d("navigate reset password");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }
}
