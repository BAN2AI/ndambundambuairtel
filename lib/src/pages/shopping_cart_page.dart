import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/payement.dart';
import 'package:flutter_ecommerce_app/src/pages/payment_cart.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  int total = 0;
  int nbr = 0;

  List<dynamic> panier = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // padding: AppTheme.padding,
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("Shopping Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: LightColor.orange,
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _cartItems(),

              // _price(),
              SizedBox(height: 30),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartItems() {
    return FutureBuilder(
        future: Provider().getPanier(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          total = 0;
          nbr = 0;
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            List<Widget> prods = [];
            for (var i in snapshot.data) {
              total += (i["price"].toInt() * i['quantite']);
              nbr++;
              panier.add(i);
              prods.add(Container(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(i["image"]),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    // AspectRatio(
                    //   aspectRatio: 1.2,
                    //   child: Stack(
                    //     children: <Widget>[
                    //       Align(
                    //         alignment: Alignment.topLeft,
                    //         child: Container(
                    //           height: 70,
                    //           width: 70,
                    //           child: Stack(
                    //             children: <Widget>[
                    //               Align(
                    //                 alignment: Alignment.bottomLeft,
                    //                 child: Container(
                    //                   decoration: BoxDecoration(
                    //                       color: LightColor.lightGrey,
                    //                       borderRadius:
                    //                           BorderRadius.circular(10)),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         top: 0,
                    //         left: 0,
                    //         child: Container(
                    //           height: 200,
                    //           width: 200,
                    //           alignment: Alignment.center,
                    //           decoration: BoxDecoration(
                    //             image: DecorationImage(
                    //               image: NetworkImage(i["image"]),
                    //               fit: BoxFit.fitWidth,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                        child: ListTile(
                            title: TitleText(
                              text: i["name"],
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                TitleText(
                                  text: '\$ ',
                                  color: LightColor.red,
                                  fontSize: 12,
                                ),
                                TitleText(
                                  text: i['price'].toString(),
                                  fontSize: 14,
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 35,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: LightColor.lightGrey.withAlpha(150),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TitleText(
                                text: 'x' + i["quantite"].toString(),
                                fontSize: 12,
                              ),
                            ))),
                  ],
                ),
              ));
            }

            prods.add(_price());

            return Column(children: prods);
          } else {
            return Center(
              child: Text(
                "0",
                style:
                    TextStyle(color: Colors.white, backgroundColor: Colors.red),
              ),
            );
          }
        });
  }

  Widget _price() {
    return Column(children: [
      Divider(
        thickness: 1,
        height: 70,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleText(
            text: '${nbr.toString()} Produits',
            color: LightColor.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          TitleText(
            text: '\$${total.toString()}',
            fontSize: 18,
          ),
        ],
      ),
    ]);
  }

  Widget _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PayementCart(
                      product: panier,
                      order: {
                        'totale': total.toString(),
                      },
                    )));
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(LightColor.orange),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 4),
        width: AppTheme.fullWidth(context) * .75,
        child: TitleText(
          text: 'Passer au payement',
          color: LightColor.background,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  double getPrice() {
    double price = 0;
    AppData.cartList.forEach((x) {
      price += x.price * x.id;
    });
    return price;
  }
}
