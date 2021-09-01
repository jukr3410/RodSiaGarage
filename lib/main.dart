import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/appbarGarage.dart';
import 'package:rodsiagarage/global_widgets/bottomBar.dart';
import 'package:rodsiagarage/request_service_feature/widgets/alertRequestService.dart';
import 'package:rodsiagarage/request_service_feature/widgets/moreInfoRequestPage.dart';
import 'package:rodsiagarage/router.dart';

void main() {
  Bloc.observer = GarageBlocObserver();
  runApp(RodSiaGarageApp(router: AppRouter()));
}

class RodSiaGarageApp extends StatelessWidget {
  final AppRouter router;

  const RodSiaGarageApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MoreInfoRequestPage(),
      ),
      // onGenerateRoute: router.generateRoute,
    );
  }
}

class GarageBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
