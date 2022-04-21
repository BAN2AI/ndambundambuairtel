import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/splash/components/body.dart';

class SplashS extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen

    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
