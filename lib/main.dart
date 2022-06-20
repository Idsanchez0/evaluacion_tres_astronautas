// @dart=2.9

import 'dart:io';
import 'package:evaluacion_tres_astronautas/SizeConfig/SizeConfig.dart';
import 'package:evaluacion_tres_astronautas/Views/Loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [ // English, no country code
                  const Locale('es', 'ES'), // Arabic, no country code
                ],
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  /*accentColor: HexColor("00A1D2"),
                primaryColor: HexColor("253166"),*/
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                locale: const Locale('es','ES'),
                home: Loading()
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}