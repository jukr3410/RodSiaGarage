import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/repository/service_repository.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/add_service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/addService.dart';
import 'package:rodsiagarage/register_garage_feature/bloc/register_bloc.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/registerScreen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: RegisterScreen()));
      case REGISTER_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => RegisterBloc(),
                child: RegisterScreen()));
      case EDIT_GARAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => Center(child: Text("Edit garage info")));
      case ADD_SERVICE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ServiceBloc(serviceRepository: ServiceRepository()),
                child: AddServiceScreen()));
      case ADD_SERVICE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ServiceBloc(serviceRepository: ServiceRepository()),
                child: AddServiceScreen()));
      case EDIT_SERVICE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => Center(child: Text("Edit service")));
      default:
        return MaterialPageRoute(
            builder: (_) => Center(child: Text("Invalid Route")));
        ;
    }
  }
}
