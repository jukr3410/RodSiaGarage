import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/add_service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/addService.dart';
import 'package:rodsiagarage/global_widgets/homePage.dart';
import 'package:rodsiagarage/register_garage_feature/bloc/register_bloc.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/registerScreen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: RegisterScreen()));
      case ADD_SERVICE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => AddServiceBloc(),
                child: AddServiceScreen()));
      case HOMEPAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: HomePage()));
      default:
        return null;
    }
  }
}
