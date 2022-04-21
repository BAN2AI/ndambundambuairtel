import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/pages/search.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/produ%20_card2.dart';
import 'package:flutter_ecommerce_app/src/widgets/product_card.dart';
import 'package:flutter_ecommerce_app/src/widgets/product_icon.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';

import 'categorie.dart';

class HousePage extends StatefulWidget {
  HousePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HousePageState createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
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
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryListHome
            .map(
              (category) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage(
                              categorie: category.name,
                            )),
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
      height: AppTheme.fullWidth(context) * .7,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: AppData.productListHouse
            .map(
              (product) => product.category == "meuble"
                  ? ProductCard(
                      product: product,
                      onSelected: (model) {
                        setState(() {
                          AppData.productList.forEach((item) {
                            item.isSelected = false;
                          });
                          model.isSelected = true;
                        });
                      },
                    )
                  : ProductCard2(
                      product: product,
                      onSelected: (model) {
                        setState(() {
                          AppData.productList.forEach((item) {
                            item.isSelected = false;
                          });
                          model.isSelected = true;
                        });
                      },
                    ),
            )
            .toList(),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
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
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Rechercher un logement",
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
              margin: EdgeInsets.symmetric(vertical: 10),
              width: AppTheme.fullWidth(context),
              height: AppTheme.fullHeight(context) * 0.7,
              child: FutureBuilder(
                  future: Provider().getProductsByCategorie("6"),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.length > 0 ||
                          snapshot.data['data'].length > 0) {
                        List<Widget> prods = [];
                        Product product;
                        for (var i in snapshot.data['data']) {
                          product = Product(
                              id: i['id'],
                              category: i['category']['name'],
                              description: i['description'],
                              isliked: false,
                              name: i['name'],
                              price: i['price'].toDouble(),
                              familyprice: i['familyprice'].toDouble(),
                              partprice: i['partprice'].toDouble(),
                              isSelected: true,
                              image: Provider().getHost() +
                                  "assets/" +
                                  i['image']);
                          prods.add(GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                          pr: product,
                                        )),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height * .5,
                              child: ProductCard2(
                                product: product,
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
                          ));
                        }
                        return prods.length > 0
                            ? GridView(
                                padding: EdgeInsets.all(10),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4 / 6,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                children: prods,
                              )
                            : Center(
                                child: Icon(
                                CupertinoIcons.cube_box,
                                size: 50,
                              ));
                      } else {
                        return Center(
                            child: Icon(
                          CupertinoIcons.cube_box,
                          size: 50,
                        ));
                      }
                    } else {
                      return Center(
                          child: Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()));
                    }
                  }),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
