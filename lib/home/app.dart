import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/splash.dart';
import 'package:rodsiagarage/home/appBar.dart';
import 'package:rodsiagarage/login_feature/widgets/login.dart';

class App extends StatelessWidget {
  var _duration = new Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Splash();

      ///when state is AuthenticationUninitialized
    }, listener: (context, state) {
      if (state is AuthenticationUnauthenticated) {
        Timer(_duration, () {
          Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
        });
      }

      if (state is AuthenticationAuthenticated) {
        Timer(_duration, () {
          Navigator.pushReplacementNamed(context, MAIN_ROUTE);
        });
      }
    });
  }
}
