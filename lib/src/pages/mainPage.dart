import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/pages/account.dart';
import 'package:flutter_ecommerce_app/src/pages/electro.dart';
import 'package:flutter_ecommerce_app/src/pages/home_page.dart';
import 'package:flutter_ecommerce_app/src/pages/house.dart';
import 'package:flutter_ecommerce_app/src/pages/login.dart';
import 'package:flutter_ecommerce_app/src/pages/product_Saved.dart';
import 'package:flutter_ecommerce_app/src/pages/search.dart';
import 'package:flutter_ecommerce_app/src/pages/shopping_cart_page.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isHomePageSelected = true;

  int currentpage = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      color: LightColor.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _key.currentState.openDrawer();
                },
                child: RotatedBox(
                  quarterTurns: 4,
                  child: Icon(
                    Icons.sort,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Image.asset('assets/logoapp.png'),
                height: 30,
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                      // color: Theme.of(context).backgroundColor,
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Color(0xfff8f8f8),
                      //       blurRadius: 10,
                      //       spreadRadius: 10),
                      // ],
                      ),
                  child: Stack(
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.white),
                      FutureBuilder(
                          future: Provider().getPanierNbr(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              print(snapshot.data);
                              return Center(
                                  child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ));
                            } else {
                              return Center(
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.red),
                                ),
                              );
                            }
                          }),
                    ],
                  )),
            ),
          ).ripple(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCartPage()),
            );
          }, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: getTitle(),
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Spacer(),
            !isHomePageSelected
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete_outline,
                      color: LightColor.orange,
                    ),
                  ).ripple(() {},
                    borderRadius: BorderRadius.all(Radius.circular(13)))
                : SizedBox()
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    print(index);
    if (index == 0) {
      setState(() {
        currentpage = 0;
      });
    } else if (index == 1) {
      setState(() {
        currentpage = 1;
      });
    } else if (index == 2) {
      setState(() {
        currentpage = 2;
      });
    } else {
      setState(() {
        currentpage = 3;
      });
    }
  }

  Widget _buildChild() {
    if (currentpage == 1) {
      return ElectroPage();
    } else if (currentpage == 2) {
      return HousePage();
    } else if (currentpage == 3) {
      return ProfilePage();
    } else {
      return MyHomePage();
    }
  }

  String getTitle() {
    if (currentpage == 1) {
      return "Quel appareil \n vous plairez ?";
    } else if (currentpage == 2) {
      return "Une Logement \n vous interresse ?";
    } else if (currentpage == 3) {
      return "Ma WishList ";
    } else {
      return "Quel evennement \n vous attend ?";
    }
  }

  dynamic users = Provider().getUserLocal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            FutureBuilder(
                future: Provider().getUserLocal(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data);
                    return UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: LightColor.background),
                      accountEmail: Text(snapshot.data['phone_number']),
                      accountName: Text(snapshot.data['username']),
                      currentAccountPicture: CircleAvatar(
                        child: Text(snapshot.data['username'].substring(0, 2)),
                      ),
                    );
                  } else {
                    return Center(child: new CircularProgressIndicator());
                  }
                }),
            ListTile(
              leading: Icon(Icons.home, color: LightColor.orange),
              title: Text(
                "Accueil",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF30384A),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                print("Home Clicked");
              },
            ),
            ListTile(
              leading: Icon(Icons.book, color: LightColor.orange),
              title: Text(
                "Payements en attente",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF30384A),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                print("Categories Clicked");
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.notifications_active, color: LightColor.orange),
              title: Text(
                "Notifications",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF30384A),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                print("Add Clicked");
              },
            ),
            ListTile(
              leading: Icon(Icons.live_help_rounded, color: LightColor.orange),
              title: Text(
                "Aide & Support",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF30384A),
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                print("Rate Clicked");
              },
            ),
            ListTile(
              title: Container(
                padding: EdgeInsets.only(
                  top: 2.0,
                  bottom: 2.0,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: LightColor.orange),
                child: TextButton(

                    // color: redcolor,

                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => LoginSignupScreen()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Deconnexion",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    )),
              ),
              onTap: () {
                print("Privacy Clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(),
                    // _title(),
                    Expanded(
                      child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeInToLinear,
                          switchOutCurve: Curves.easeOutBack,
                          child: _buildChild()),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
