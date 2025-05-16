import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:toastification/toastification.dart';

final globalScaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Modular.setInitialRoute('/auth/');
    return ToastificationWrapper(
      child: MaterialApp.router(
        scaffoldMessengerKey: globalScaffoldMessageKey,
        debugShowCheckedModeBanner: false,
        title: 'Trade Result',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
        routerDelegate: Modular.routerDelegate,
        routeInformationParser: Modular.routeInformationParser,
      ),
    );
  }
}
