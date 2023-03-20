import 'dart:ui';
import 'package:dental_asistanim/path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';

dynamic ctrl; // Created here to keep working with Hot Reload

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); */
  runApp(MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr', 'TR'), // Thai
      ],
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 26, 184, 87),
        accentColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Align(
          alignment: Alignment.center,
          child: AnimatedSplashScreen(
              duration: 500,
              splash: new Image.asset('assets/indir.png'),
              nextScreen: path(),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.rightToLeftWithFade,
              backgroundColor: Colors.white))));
}
