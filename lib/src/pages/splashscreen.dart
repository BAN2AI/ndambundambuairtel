import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/pages/login.dart';

import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';

import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [
      Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/travel.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.7, 0.9],
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black45,
                      Colors.black54,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text("khkhkj",
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //
                      //         fontSize: 36,
                      //         fontWeight: FontWeight.bold)),
                      // SizedBox(height: 10),

                      Container(
                        alignment: Alignment.center,
                        height: 130.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                            " Achetez vos billez d'avions d'avion facilitement a compte goute ou en cash, plus besoin de faire de se deplacer vers les agences ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: LightColor.background,
                              fontSize: 19,
                            )),
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                )),
          ],
        ),
      ),
      Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/concert.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.7, 0.9],
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black45,
                      Colors.black54,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text("khkhkj",
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //
                      //         fontSize: 36,
                      //         fontWeight: FontWeight.bold)),
                      // SizedBox(height: 10),

                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 130.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                            "Plus besoin de vous deplacer ou de ratter des concert , achetez vos billets en cash ou a conte goute , en ligne en quelques clics",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: LightColor.background,
                              fontSize: 19,
                            )),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                )),
          ],
        ),
      ),
      Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/wallp.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.7, 0.9],
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black45,
                      Colors.black54,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text("khkhkj",
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //
                      //         fontSize: 36,
                      //         fontWeight: FontWeight.bold)),
                      // SizedBox(height: 10),

                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 130.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                            "Offrez de l'electromenager haut de game a votre famille, des nouveaux appareils pour votre confort",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: LightColor.background,
                              fontSize: 19,
                            )),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                )),
          ],
        ),
      ),
      Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/p5-min.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.7, 0.9],
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black45,
                      Colors.black54,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text("khkhkj",
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //
                      //         fontSize: 36,
                      //         fontWeight: FontWeight.bold)),
                      // SizedBox(height: 10),

                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 130.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                            "Achetez tout ces produits de votre airtel money , en cash ou eb plusieurs paiements",
                            style: TextStyle(
                              color: LightColor.background,
                              fontSize: 19,
                            )),
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                )),
          ],
        ),
      )
    ];

    return Container(
        child: Stack(
      children: <Widget>[
        LiquidSwipe(
          pages: data,
          enableLoop: false,
          onPageChangeCallback: pageChangeCallback,
          waveType: WaveType.liquidReveal,
          liquidController: liquidController,
          ignoreUserGestureWhileAnimating: true,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(data.length, _buildDot),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 0),
            child: FlatButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginSignupScreen(),
                    ),
                    (route) => false);
              },
              child: Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.blue)),
              color: Colors.white.withOpacity(0.01),
            ),
          ),
        ),
      ],
    ));
  }

  pageChangeCallback(int lpage) {
    if (page == 4) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
          (route) => false);
    }
    setState(() {
      page = lpage;
    });
  }
}
