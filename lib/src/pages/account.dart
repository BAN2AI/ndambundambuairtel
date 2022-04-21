import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/produ%20_card2.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
        body: FutureBuilder(
            future: Provider().getWishList(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print("object\n \n ");
                print(snapshot.data);
                if (snapshot.data.length > 0) {
                  List<Widget> prods = [];
                  Product product;
                  for (var i in snapshot.data['data']) {
                    product = Product(
                        id: i['id'],
                        category: i['category'].toString(),
                        description: i['description'],
                        isliked: false,
                        name: i['name'],
                        price: i['price'].toDouble(),
                        familyprice: i['familyprice'].toDouble(),
                        partprice: i['partprice'].toDouble(),
                        isSelected: true,
                        image: Provider().getHost() + "assets/" + i['image']);
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
                        child: FutureBuilder(
                            future: Provider().getProductById(product.id),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  height:
                                      MediaQuery.of(context).size.height * .5,
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
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            })));
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
                          CupertinoIcons.bag_badge_plus,
                          size: 50,
                        ));
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.bag_badge_plus,
                        size: 50,
                      ),
                      Text(
                        "Votre wishlist est vide",
                        style: TextStyle(color: Colors.black26),
                      )
                    ],
                  ));
                }
              } else {
                return Center(
                    child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()));
              }
            }));
  }
}
