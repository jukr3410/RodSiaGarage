import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_login.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/profile_feature/bloc/profile_bloc.dart';

class EditPassword extends StatefulWidget {
  final Garage garage;
  const EditPassword({Key? key, required this.garage}) : super(key: key);

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final _passwordOldConTroller = TextEditingController();
  final _passwordNewConTroller = TextEditingController();

  late ProfileBloc _profileBloc;
  String passwordOld = '';
  String passwordNew = '';
  late Garage _garage;

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
          title: Text('แก้ไขรหัสผ่าน'),
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
            if (state is CheckPasswordError) {
              _profileBloc.close();
              return _navigateToErrorPassword(context);
            } else if (state is CheckPasswordSuccesss) {
              return _navigateAndDisplayEdit(context);
            } else if (state is ProfileUpdated) {
              _profileBloc.add(ProfileLoadFormPhone());
            } else if (state is GarageLoadSuccess) {
              _garage = state.garage;
              return navigatorToProfilePage(_garage);
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('รหัสผ่านเก่า'),
                                  TextFormField(
                                      onChanged: (String value) {
                                        passwordOld = value;
                                        logger.d('passwordOld: ' + passwordOld);
                                      },
                                      // maxLength: 25,
                                      controller: _passwordOldConTroller,
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                        hintText: 'รหัสผ่านเก่า',
                                        hintStyle: TextStyle(
                                            color: textColorBlack,
                                            fontSize: 15),
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                "Please, input old password."),
                                        // MinLengthValidator(14,
                                        //     errorText:
                                        //         "Phone should be atleast 10 number."),
                                      ])),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('รหัสผ่านใหม่'),
                                  TextFormField(
                                      onChanged: (String value) {
                                        passwordNew = value;
                                        logger.d('passwordNew: ' + passwordNew);
                                      },
                                      // maxLength: 25,
                                      controller: _passwordNewConTroller,
                                      keyboardType: TextInputType.name,
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
                                        hintText: 'รหัสผ่านใหม่',
                                        hintStyle: TextStyle(
                                            color: textColorBlack,
                                            fontSize: 15),
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                "Please, input new password."),
                                        MinLengthValidator(10,
                                            errorText:
                                                "Phone should be atleast 10 number."),
                                      ])),
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
                                GarageLogin garageLogin = GarageLogin(
                                    phone: widget.garage.phone,
                                    password: passwordOld);
                                _profileBloc.add(
                                    CheckPassword(garageLogin: garageLogin));
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

  _addOrChangeProfileImage(String profileImage) {
    if (profileImage == '') {
      return Positioned(
          bottom: 5,
          right: 25,
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
                color: textColorBlack, borderRadius: borderRadiusHight),
          ));
    } else {
      return GFButton(
        onPressed: () {},
        type: GFButtonType.transparent,
        textStyle: TextStyle(color: textColorBlack, fontSize: fontSizeS),
        child: Text('เปลี่ยนรูปภาพ'),
      );
    }
  }

  void _navigateAndDisplayEdit(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopupYesNo(
              title: 'คุณต้องการอัพเดตข้อมูลใช้ไหม',
            ));
    if (result == 'Ok') {
      widget.garage.password = passwordNew;
      _profileBloc.add(GarageUpdatePassword(widget.garage));
    }
  }

  void _navigatorToEditPassword() {
    Navigator.pushNamed(context, EDIT_PASSWOED_ROUTE, arguments: widget.garage);
  }

  // void _navigateAndDisplayEditError(BuildContext context) async {
  //   final result = await showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) => AlertPopupYesNo(
  //             title: 'คุณใล่รหัสผ่านไม่ตรงกัน',
  //           ));
  //   if (result == 'Ok') {}
  // }

  void _navigateToErrorPassword(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _AlertErrorPinPassword());
    if (result == 'Ok') {
      Navigator.pop(context);
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
}
