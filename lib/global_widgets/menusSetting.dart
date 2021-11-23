import 'package:cached_network_image/cached_network_image.dart';
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
        if (state is AuthenticationUnauthenticated) {
          navigateToLogin();
        }
      },
      builder: (context, state) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(color: textColorBlack
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [
                  //   Colors.black87,
                  //   Colors.black54,
                  //   Colors.black45
                  // ])
                  ),
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
                          child: _profileImage(
                              widget.garage.logoImage.toString())),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 130,
                      child: Text(
                        widget.garage.name,
                        style: TextStyle(
                            fontSize: fontSizeXXl, color: primaryColor),
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                                    child: ListView.builder(
                                        itemCount: menusSetting.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                child: Text(
                                                  menusSetting[index]
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: textColorBlack,
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (index ==
                                                      menusSetting.length - 1) {
                                                    _authenticationBloc
                                                        .add(LoggedOut());
                                                  } else {
                                                    navigator(menusSettingRoute[
                                                        index]);
                                                  }
                                                },
                                              ),
                                              Divider(
                                                color: textColorBlack,
                                              ),
                                            ],
                                          );
                                        })))),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _profileImage(String image) {
    if (image == '') {
      return Image.asset(
        tImageAsset('profile'),
        fit: BoxFit.cover,
        width: 130,
        height: 130,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        width: 130,
        height: 130,
      );
    }
  }

  void navigator(String route) {
    Navigator.pushNamed(context, route, arguments: widget.garage);
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }
}
