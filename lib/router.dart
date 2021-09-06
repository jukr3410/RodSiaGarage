import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';
import 'package:rodsiagarage/core/repository/service_repository.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/add_service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/addService.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/editService.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/serviceList.dart';
import 'package:rodsiagarage/global_widgets/homePage.dart';
import 'package:rodsiagarage/global_widgets/invalidRoute.dart';
import 'package:rodsiagarage/home/app.dart';
import 'package:rodsiagarage/home/bloc/home_bloc.dart';
import 'package:rodsiagarage/home/appBar.dart';
import 'package:rodsiagarage/login_feature/bloc/login_bloc.dart';
import 'package:rodsiagarage/login_feature/widgets/login.dart';
import 'package:rodsiagarage/register_garage_feature/bloc/register_bloc.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/registerScreen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    print("Route: $settings");
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    AuthenticationBloc(garageRepository: GarageRepository())
                      ..add(AppStarted()),
                child: App()));

      case MAIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => HomeBloc(),
                child: CustomAppBar()));

      case LOGIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => LoginBloc(),
                  child: LoginScreen(),
                ));

      case REGISTER_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: RegisterScreen()));

      case EDIT_GARAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => Center(child: Text("Edit garage info")));

      case SERVICE_LIST_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ServiceBloc(serviceRepository: ServiceRepository()),
                child: ServiceListScreen()));

      case ADD_SERVICE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ServiceBloc(serviceRepository: ServiceRepository()),
                child: AddServiceScreen()));

      case EDIT_SERVICE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ServiceBloc(serviceRepository: ServiceRepository()),
                child: EditServiceScreen()));

      // case HOMEPAGE_ROUTE:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //           create: (BuildContext context) => RegisterBloc(),
      //           child: HomePage()));

      default:
        return MaterialPageRoute(builder: (_) => InvalidRouteScreen());
    }
  }
}
