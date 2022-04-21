import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart';
import 'package:flutter_ecommerce_app/src/pages/login.dart';
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/pages/splashscreen.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/splash/splash_screen.dart';
import 'package:flutter_ecommerce_app/src/widgets/customRoute.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'src/themes/theme.dart';

void main() => {tz.initializeTimeZones(), runApp(MyApp())};

class MyApp extends StatelessWidget {
  // bool opened = Provider().getAlreadyOpened();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Airtel ndambu ndambu',
        theme: AppTheme.lightTheme.copyWith(
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: Provider().getAlreadyOpened(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              print(snapshot.data);
              print("this is the solution");

              if (snapshot.connectionState == ConnectionState.done) {
                bool opened = snapshot.data;
                // YOUR CUSTOM CODE GOES HERE
                return SplashScreen(
                    seconds: 2,
                    navigateAfterSeconds: opened == null || opened == false
                        ? SplashS()
                        : LoginSignupScreen(),
                    image: new Image.asset('assets/logo.png'),
                    backgroundColor: Color(0xFFFF0024),
                    styleTextUnderTheLoader: new TextStyle(),
                    photoSize: 100.0,
                    loaderColor: Colors.white);
              } else {
                return new CircularProgressIndicator();
              }
            }));
  }
}

Widget SplashRed() {
  return Scaffold(
    backgroundColor: Color(0xFFEA0E00),
    body: SplashScreen(),
  );
}
