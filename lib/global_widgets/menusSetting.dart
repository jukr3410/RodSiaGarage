import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/profile_feature/bloc/profile_bloc.dart';

class MenusSetting extends StatefulWidget {
  final Garage garage;
  MenusSetting({Key? key, required this.garage}) : super(key: key);

  @override
  _MenusSettingState createState() => _MenusSettingState();
}

class _MenusSettingState extends State<MenusSetting> {
  late AuthenticationBloc _authenticationBloc;
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          navigateToLogin();
        }
      },
      builder: (context, state) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return SafeArea(
              child: Container(
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
                  body: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 70,
                        child: ClipOval(
                          child: Image.asset(
                            tImageAsset('profile-homePage'),
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        // widget.user.name,
                        widget.garage.name,
                        style: TextStyle(fontSize: fontSizeLarge),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: borderRadiusHightOnlyTop,
                                color: bgColor),
                            child: Padding(
                                padding:
                                    const EdgeInsets.all(defualtPaddingHight),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Colors.grey.shade400,
                                    ))),
                                    child: Column(
                                      children: [
                                        _TextButtonManus(
                                            menusSetting[0], PROFILE_ROUTE),
                                        _TextButtonManus(
                                            menusSetting[1], PROFILE_ROUTE),
                                        _TextButtonManus(
                                            menusSetting[2], PROFILE_ROUTE),
                                        _TextButtonManus(
                                            menusSetting[3], PROFILE_ROUTE),
                                      ],
                                    ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _TextButtonManus(String name, String route) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 35,
          child: TextButton(
            onPressed: () {
              if (name == menusSetting[3]) {
                _authenticationBloc.add(LoggedOut());
              } else {
                navigator(route);
              }
            },
            child: (Text(
              name,
              style: TextStyle(
                fontSize: fontSizeMedium,
                color: textColorBlack,
              ),
            )),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  void navigator(String route) {
    Navigator.pushNamed(context, route, arguments: widget.garage);
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }
}
