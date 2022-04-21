import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/produ%20_card2.dart';

class SearchPage extends StatefulWidget {
  final String keyword;

  const SearchPage({Key key, this.keyword}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text("Recherche", style: TextStyle(color: Colors.white)),
          backgroundColor: LightColor.orange,
          shadowColor: Colors.white.withOpacity(0),
        ),
        body: FutureBuilder(
            future: Provider().getProductsbyName(widget.keyword),
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
                        category: i['category']['name'].toString(),
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
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              Icon(
                                CupertinoIcons.cube_box,
                                size: 50,
                              ),
                              Text("Accun element trouver pour '" +
                                  widget.keyword +
                                  "'")
                            ]));
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
            }));
  }
}
