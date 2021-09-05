import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/alertPopupBackHomePage.dart';
import 'package:rodsiagarage/global_widgets/appbarGarage.dart' as _appbar;
import 'package:rodsiagarage/global_widgets/splash.dart';
import 'package:rodsiagarage/request_service_feature/widgets/moreInfoRequestCard.dart';
import 'package:rodsiagarage/request_service_feature/widgets/moreInfoRequestPage.dart';
import 'package:logging/logging.dart';
import 'package:rodsiagarage/request_service_feature/widgets/trackingRequestPage.dart';
import 'package:rodsiagarage/router.dart';
import 'package:logging/logging.dart';
import 'package:fswitch/fswitch.dart';

void main() {
  _setupLogging();
  Bloc.observer = GarageBlocObserver();
  runApp(RodSiaGarageApp(router: AppRouter()));
}

class RodSiaGarageApp extends StatelessWidget {
  final AppRouter router;

  const RodSiaGarageApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(home: Splash());
          } else
            return MaterialApp(
              theme: ThemeData(fontFamily: 'Kanit'),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: _appBar,
                body: AlertPopupBackHomePage(),
              ),
              // onGenerateRoute: router.generateRoute,
            );
        });
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

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

AppBar _appBar = AppBar(
  // centerTitle: true,
  backgroundColor: primaryColor,
  actions: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 65),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            // LiteRollingSwitch(
            //   value: true,
            //   textOn: '  Online',
            //   textOff: '  Offline',
            //   colorOn: Colors.green,
            //   colorOff: Colors.blueGrey,
            //   // iconOn: Icons.online_prediction_rounded,
            //   // iconOff: Icons.power_settings_new,
            //   onChanged: (value) {
            //     print('turned ${(value) ? 'on' : 'off'}');
            //   },
            // ),
            FSwitch(
              open: true,
              height: 25,
              width: 70,
              onChanged: (v) {},
              closeChild: Text(
                'Offline',
                style: TextStyle(fontSize: 12),
              ),
              openChild: Text(
                'Online',
                style: TextStyle(fontSize: 12),
              ),
              openColor: Colors.green,
            ),
          ],
        ),
      ),
    ),
    TextButton(
        onPressed: () {},
        child: ImageIcon(
          AssetImage('assets/images/icon-notify.png'),
          color: textColorBlack,
        )),
  ],
);
