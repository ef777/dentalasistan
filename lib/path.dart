import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dental_asistanim/errorpage.dart';
import 'package:dental_asistanim/giris.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
//import OneSignal
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config.dart';
import 'home_view.dart';

class path extends StatelessWidget {
  const path({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dental Asistanım',
      debugShowCheckedModeBanner: false,
      initialRoute: Config.login == '0' ? '/login' : '/',
      routes: {
        '/': (context) => HomeView(
              name: Config.name,
            ),
        '/login': (context) => LoginScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => HomeView(
                name: Config.name,
              ),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (context) => LoginScreen(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => errorpage(),
            );
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const errorpage());
      },
    );
  }
}
