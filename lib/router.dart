import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';
import 'package:rodsiagarage/core/repository/request_service_repository.dart';
import 'package:rodsiagarage/core/repository/service_repository.dart';
import 'package:rodsiagarage/core/repository/service_type_repository.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_type_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/addService.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/editService.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/serviceList.dart';
import 'package:rodsiagarage/global_widgets/supportCenterPage.dart';
import 'package:rodsiagarage/history_feature/widgets/historyInfoPage.dart';
import 'package:rodsiagarage/history_feature/widgets/listHistory.dart';
import 'package:rodsiagarage/home_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiagarage/home_feature/widgets/homePage.dart';
import 'package:rodsiagarage/global_widgets/invalidRoute.dart';
import 'package:rodsiagarage/home/app.dart';
import 'package:rodsiagarage/home/bloc/home_bloc.dart';
import 'package:rodsiagarage/home/appBar.dart';
import 'package:rodsiagarage/login_feature/bloc/login_bloc.dart';
import 'package:rodsiagarage/login_feature/widgets/login.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/notify_feature/widgets/notifyFormSelectPage.dart';
import 'package:rodsiagarage/notify_feature/widgets/notifyPage.dart';
import 'package:rodsiagarage/profile_feature/bloc/profile_bloc.dart';
import 'package:rodsiagarage/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiagarage/profile_feature/widgets/editImageGarage.dart';
import 'package:rodsiagarage/profile_feature/widgets/editPassword.dart';
import 'package:rodsiagarage/profile_feature/widgets/editProfile.dart';
import 'package:rodsiagarage/register_garage_feature/bloc/register_bloc.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/addInfo.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/addNumber.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/otp.dart';
import 'package:rodsiagarage/request_service_feature/widgets/requestDetailAndGiveStarPage.dart';
import 'package:rodsiagarage/request_service_feature/widgets/trackingRequestPage.dart';
import 'package:rodsiagarage/history_feature/bloc/request_service_bloc.dart'
    as historyBloc;

import 'core/models/service_model.dart';

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
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (BuildContext context) => AuthenticationBloc(
                          garageRepository: GarageRepository())),
                  BlocProvider(
                    create: (BuildContext context) => HomeBloc(),
                  ),
                  BlocProvider(
                    create: (BuildContext context) =>
                        ProfileBloc(garageRepository: GarageRepository()),
                  ),
                  BlocProvider(
                      create: (BuildContext context) =>
                          GarageInfoBloc(garageRepository: GarageRepository()))
                ], child: CustomAppBar()));

      case LOGIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<LoginBloc>(
                        create: (BuildContext context) => LoginBloc(
                            garageRepository: GarageRepository(),
                            authenticationBloc: AuthenticationBloc(
                                garageRepository: GarageRepository()))),
                  ],
                  child: LoginScreen(),
                ));

      case ADD_NUMBER_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    RegisterBloc(garageRepository: GarageRepository()),
                child: AddNumber()));

      case OTP_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    RegisterBloc(garageRepository: GarageRepository()),
                child: Otp(garage: garage)));

      case REGISTER_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    RegisterBloc(garageRepository: GarageRepository()),
                child: AddInfo(garage: garage)));

      case EDIT_GARAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => Center(child: Text("Edit garage info")));

      case SERVICE_LIST_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (BuildContext context) =>
                            ServiceBloc(serviceRepository: ServiceRepository()),
                      ),
                      BlocProvider(
                        create: (BuildContext context) => ServiceTypeBloc(
                            serviceTypeRepository: ServiceTypeRepository()),
                      ),
                    ],
                    child: ServiceListScreen(
                      garage: garage,
                    )));

      case ADD_SERVICE_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ServiceBloc>(
                          create: (BuildContext context) => ServiceBloc(
                              serviceRepository: ServiceRepository())),
                      BlocProvider<ServiceTypeBloc>(
                          create: (BuildContext context) => ServiceTypeBloc(
                              serviceTypeRepository: ServiceTypeRepository())),
                    ],
                    child: AddServiceScreen(
                      garage: garage,
                    )));

      case EDIT_SERVICE_ROUTE:
        EditService editService = settings.arguments as EditService;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<ServiceBloc>(
                      create: (BuildContext context) =>
                          ServiceBloc(serviceRepository: ServiceRepository())),
                  BlocProvider<ServiceTypeBloc>(
                      create: (BuildContext context) => ServiceTypeBloc(
                          serviceTypeRepository: ServiceTypeRepository())),
                ], child: EditServiceScreen(editService: editService)));

      case TRACKING_REQUEST_ROUTE:
        return MaterialPageRoute(builder: (_) => TrackingRequestPage());

      case RECAP_DETAIL_REQUREST_ROUTE:
        RequestService requestService = settings.arguments as RequestService;
        return MaterialPageRoute(
            builder: (_) => DetailAndGiveStarPage(
                  requestService: requestService,
                ));

      case HOMEPAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    GarageInfoBloc(garageRepository: GarageRepository()),
                child: HomePage()));

      case PROFILE_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(builder: (_) => ProfilePage(garage: garage));

      case EDITPROFILE_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ProfileBloc(garageRepository: GarageRepository()),
                child: EditProfile(
                  garage: garage,
                )));
      case EDIT_PASSWOED_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    ProfileBloc(garageRepository: GarageRepository()),
                child: EditPassword(
                  garage: garage,
                )));

      case EDIR_IMAGES_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => EditImageGarage(garage: garage));

      case SUPPORT_CENTER_ROUTE:
        return MaterialPageRoute(builder: (_) => SupportCenterPage());

      case NOTIFY_ROUTE:
        NotifyInfo notify = settings.arguments as NotifyInfo;
        return MaterialPageRoute(
            builder: (_) => NotifyFromSelectPage(notify: notify));

      case HISTORY_ROUTE:
        Garage garage = settings.arguments as Garage;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    historyBloc.RequestServiceBloc(
                        requestServiceRepository: RequestServiceRepository()),
                child: Listhistory(
                  garage: garage,
                )));

      case HISTORY_INFO_ROUTE:
        RequestService requestService = settings.arguments as RequestService;
        return MaterialPageRoute(
            builder: (_) => HistoryInfoPage(requestService: requestService));

      default:
        return MaterialPageRoute(builder: (_) => InvalidRouteScreen());
    }
  }
}
