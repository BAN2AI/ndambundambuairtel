import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  bool isMale = true;
  bool isRememberMe = false;

  TextEditingController numberController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/wallp.jpg"), fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: LightColor.orange.withOpacity(.9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bienvenu",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? "Enregistrez-vous pour continuer"
                          : "Connectez vous",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 250,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Connexion",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? LightColor.red
                                        : LightColor.titleTextColor),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 20,
                                  color: LightColor.red,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Inscription",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? LightColor.red
                                        : LightColor.titleTextColor),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 20,
                                  color: LightColor.red,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          buildTextField(Icons.phone_android, "Numero", false, false,
              !isSignupScreen ? numberController : null),
          buildTextField(Icons.lock_outline, "Mot de passe", true, false,
              !isSignupScreen ? passwordController : null),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row(
              //   children: [
              //     Checkbox(
              //       value: isRememberMe,
              //       activeColor: LightColor.subTitleTextColor,
              //       onChanged: (value) {
              //         setState(() {
              //           isRememberMe = !isRememberMe;
              //         });
              //       },
              //     ),
              //     Text("Se souvenir de moi",
              //         style: TextStyle(
              //             fontSize: 12, color: LightColor.titleTextColor))
              //   ],
              // ),
              TextButton(
                onPressed: () {},
                child: Text("Mot de passe oublier?",
                    style: TextStyle(
                        fontSize: 12, color: LightColor.titleTextColor)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.account_box_outlined, "Username", false, false,
              isSignupScreen ? usernameController : null),
          buildTextField(Icons.call, "Telephone", false, false,
              isSignupScreen ? numberController : null),
          buildTextField(Icons.lock_outline, "password", true, false,
              isSignupScreen ? passwordController : null),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Acceptez les  ",
                  style: TextStyle(color: LightColor.subTitleTextColor),
                  children: [
                    TextSpan(
                      //recognizer: ,
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          minimumSize: Size(145, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: GestureDetector(
        onTap: () => {
          print(numberController.text),
          print(passwordController.text),
          showDialog(
            context: context,
            builder: (_) => FunkyOverlay(),
          ),
          if (!isSignupScreen)
            {
              Provider()
                  .loginUser(numberController.text, passwordController.text)
                  .then((value) => {
                        Navigator.of(context).pop(),
                        if (value["data"].isEmpty)
                          {showAlertDialog(context)}
                        else
                          {
                            print(value["data"][0]["id"]),
                            Provider().setUser({
                              'phone_number': numberController.text,
                              'password': passwordController.text,
                              'username': value['data'][0]["username"],
                              'id': value['data'][0]["id"].toString(),
                            }),
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => MainPage()),
                                (Route<dynamic> route) => false),
                          }
                      })
            }
          else
            {
              Provider()
                  .addUser(numberController.text, usernameController.text,
                      passwordController.text)
                  .then((value) => {
                        Navigator.of(context).pop(),
                        if (value["data"].isEmpty)
                          {showAlertDialog(context)}
                        else
                          {
                            print(value["data"]["id"]),
                            showContractDialog(context),
                            Provider().setUser({
                              'phone_number': numberController.text,
                              'username': usernameController.text,
                              'password': passwordController.text,
                              'id': value['data']["id"].toString(),
                            }),
                          }
                      })
            }
        },
        child: Center(
          child: Container(
            height: 90,
            width: 90,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (showShadow)
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1.5,
                      blurRadius: 10,
                    )
                ]),
            child: !showShadow
                ? Container(
                    decoration: BoxDecoration(
                      color: LightColor.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                : Center(),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Attention"),
      content: Text("Mot de passe ou non d'utilisateur incorrect"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showContractDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("J'accepte"),
      disabledColor: Colors.grey,
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainPage()),
            (Route<dynamic> route) => false);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
          "En validant cette etape vous acceptez les conditions suivantes"),
      content: SingleChildScrollView(
        child: Column(children: [
          TitleText(
            text: "Coditions 1",
            fontSize: 14,
          ),
          Text(
              "En validant cette etape vous acceptez les onditions suivantes, En validant cette etape vous acceptez les onditions suivantes"),
          TitleText(
            text: "Coditions 1",
            fontSize: 14,
          ),
          Text(
              "En validant cette etape vous acceptez les onditions suivantes, En validant cette etape vous acceptez les onditions suivantes"),
          TitleText(
            text: "Coditions 1",
            fontSize: 14,
          ),
          Text(
              "En validant cette etape vous acceptez les onditions suivantes, En validant cette etape vous acceptez les onditions suivantes"),
          TitleText(
            text: "Coditions 1",
            fontSize: 14,
          ),
          Text(
              "En validant cette etape vous acceptez les onditions suivantes, En validant cette etape vous acceptez les onditions suivantes"),
        ]),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        keyboardType: isEmail ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: LightColor.darkgrey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: LightColor.darkgrey),
            // borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: LightColor.red),
            // borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.only(top: 15, bottom: 15),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: LightColor.lightGrey),
        ),
      ),
    );
  }
}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
