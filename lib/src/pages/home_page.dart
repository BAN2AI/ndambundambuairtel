import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ecommerce_app/src/model/category.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/categorie.dart';
import 'package:flutter_ecommerce_app/src/pages/order_detail.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/pages/search.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/accomptepro.dart';
import 'package:flutter_ecommerce_app/src/widgets/produ%20_card2.dart';
import 'package:flutter_ecommerce_app/src/widgets/product_card.dart';
import 'package:flutter_ecommerce_app/src/widgets/product_icon.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

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

  Widget _categoryWidget() {
    return Container(
      width: AppTheme.fullWidth(context),
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage(
                            categorie: category.name, id: category.id)),
                  );
                },
                child: ProductIcon(
                  model: category,
                  onSelected: (model) {
                    setState(() {
                      AppData.categoryList.forEach((item) {
                        item.isSelected = false;
                      });
                      model.isSelected = true;
                    });
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullHeight(context) * .3,
      child: FutureBuilder(
          future: Provider().getProducts('date_created'),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data['data']);
              List<Widget> prods = [];
              for (var i in snapshot.data['data']) {
                prods.add(
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                    pr: Product(
                                        id: i['id'],
                                        category: i['category']['name'],
                                        description: i['description'],
                                        isliked: false,
                                        name: i['name'],
                                        price: i['price'].toDouble(),
                                        familyprice:
                                            i['familyprice'].toDouble(),
                                        partprice: i['partprice'].toDouble(),
                                        isSelected: true,
                                        image: Provider().getHost() +
                                            "assets/" +
                                            i['image']),
                                  )));
                    },
                    child: ProductCard2(
                      product: Product(
                          id: i['id'],
                          category: i['category']['name'],
                          description: i['description'],
                          isliked: false,
                          name: i['name'],
                          price: i['price'].toDouble(),
                          familyprice: i['familyprice'].toDouble(),
                          partprice: i['familyprice'].toDouble(),
                          isSelected: true,
                          image: Provider().getHost() + "assets/" + i['image']),
                      onSelected: (model) {
                        setState(() {
                          AppData.productList.forEach((item) {
                            item.isSelected = false;
                          });
                          model.isSelected = true;
                        });
                      },
                    ),
                  ),
                );
              }
              // YOUR CUSTOM CODE GOES HERE
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 4 / 3,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20),
                padding: EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                children: prods,
              );
            } else {
              return Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _productAccWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullHeight(context) * .4,
      child: FutureBuilder(
          future: Provider().getCommandes(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("commande");
              print(snapshot.data['data']);

              List<Widget> prods = [];
              for (var i in snapshot.data['data']) {
                if (i['istranche']) {
                  prods.add(
                    AccompteProduct(
                      order: i,
                      onSelected: (model) {
                        setState(() {
                          AppData.productList.forEach((item) {
                            item.isSelected = false;
                          });
                          model.isSelected = true;
                        });
                      },
                    ),
                  );
                }
              }
              // YOUR CUSTOM CODE GOES HERE
              return prods.length > 0
                  ? GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 4 / 3,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 20),
                      padding: EdgeInsets.only(left: 20),
                      scrollDirection: Axis.horizontal,
                      children: prods,
                    )
                  : Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Icon(
                            CupertinoIcons.cube_box,
                            size: 50,
                          ),
                          Text("Accun achat en accompte")
                        ]));
            } else {
              return Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _search() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                              keyword: value,
                            )),
                  );
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Je recherche ... ",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54)
        ],
      ),
    );
  }

  dynamic sliders;
  dynamic products;
  dynamic orders;

  @override
  void initState() {
    _scaffoldKey = GlobalKey();
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _search(),
                  _categoryWidget(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                        future: Provider().getSlider(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            print(snapshot.data['data']);
                            List<Widget> slids = [];
                            for (var i in snapshot.data['data']) {
                              slids.add(Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 60,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF4A3298),
                                  image: DecorationImage(
                                      image: NetworkImage(Provider().getHost() +
                                          "assets/" +
                                          i['sliderimage']),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.centerLeft),
                                  // borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(""),
                              ));
                            }
                            // YOUR CUSTOM CODE GOES HERE
                            return PageView(
                                scrollDirection: Axis.horizontal,
                                controller: new PageController(
                                    initialPage: 0, viewportFraction: 1),
                                children: slids
                                // [
                                //   ,
                                //   Container(
                                //       width: MediaQuery.of(context).size.width,
                                //       height: MediaQuery.of(context).size.height * 0.2,
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 0,
                                //         vertical: 60,
                                //       ),
                                //       decoration: BoxDecoration(
                                //         color: Color(0xFF4A3298),
                                //         image: DecorationImage(
                                //             image: AssetImage("assets/bannerelectro.jpg"),
                                //             fit: BoxFit.cover,
                                //             alignment: Alignment.centerLeft),
                                //         // borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: Text("")),
                                //   Container(
                                //       width: MediaQuery.of(context).size.width,
                                //       height: MediaQuery.of(context).size.height * 0.2,
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 0,
                                //         vertical: 60,
                                //       ),
                                //       decoration: BoxDecoration(
                                //         color: Color(0xFF4A3298),
                                //         image: DecorationImage(
                                //             image: AssetImage("assets/70.jpg"),
                                //             fit: BoxFit.cover,
                                //             alignment: Alignment.centerLeft),
                                //         // borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: Text("")),
                                // ],
                                );
                          } else {
                            return Center(
                                child: new CircularProgressIndicator());
                          }
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 20),
                    child: Text("Nouveautes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: LightColor.darkgrey,
                            fontSize: 16)),
                  ),
                  _productWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 20),
                    child: Text("Vos achats en partie",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: LightColor.darkgrey,
                            fontSize: 16)),
                  ),
                  _productAccWidget(),
                ],
              ),
            ),
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  /// adding elements in list after [1 seconds] delay
                  /// to mimic network call

                  /// Remember: [setState] is necessary so that
                  /// build method will run again otherwise
                  /// list will not show all elements
                  setState(() {});

                  // showing snackbar
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: const Text('Page mis a jour'),
                    ),
                  );
                },
              );
            }));
  }
}
