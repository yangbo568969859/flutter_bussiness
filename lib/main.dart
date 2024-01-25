import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:seller/views/store/store_provider.dart';

import 'package:seller/style/resources.dart';

import 'package:seller/views/home/splash_page.dart';
import 'package:seller/views/login/login_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<StoreProvider>.value(
        value: StoreProvider()
      )
    ],
    child: MyApp(),
  ));
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {

  MyApp() {
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ibuybuy商家版',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Colours.app_main,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        textTheme: TextTheme(subhead: TextStyle(textBaseline: TextBaseline.alphabetic))
      ),
      home: SplashPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US')
      ],
      routes: {
        'login': (context) {
          return LoginPage();
        }
      },
    );
  }
}

Future requestPermission() async {
  // 申请权限
  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage, PermissionGroup.contacts, PermissionGroup.location]);
  print(permissions);
}
