import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/order_detail.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';

class AccompteProduct extends StatefulWidget {
  final dynamic order;
  final ValueChanged<dynamic> onSelected;
  AccompteProduct({Key key, this.order, this.onSelected}) : super(key: key);

  @override
  _AccompteProductState createState() => _AccompteProductState();
}

class _AccompteProductState extends State<AccompteProduct> {
  Product product;

  @override
  void initState() {
    super.initState();
    // getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
          ],
        ),
        child: FutureBuilder(
            future: Provider().getProductById(widget.order['product_id']),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                dynamic i = snapshot.data['data'][0];
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
                    image: Provider().getHost() + "assets/" + i['image']);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(
                                order: widget.order, product: product)));
                  },
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // SizedBox(height: order['isSelected'] ? 15 : 0),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(product.image),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter),
                                ),
                              ),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TitleText(
                                text: product.name,
                                fontSize: product.isSelected ? 16 : 14,
                              ),
                            ),
                            TitleText(
                              text: product.category,
                              fontSize: product.isSelected ? 14 : 12,
                              color: LightColor.orange,
                            ),

                            TitleText(
                              text: product.price.toString() + ' \$',
                              fontSize: product.isSelected ? 18 : 16,
                            ),

                            SliderTheme(
                              child: Slider(
                                value: 50,
                                max: 100,
                                min: 0,
                                activeColor: LightColor.orange,
                                inactiveColor: LightColor.lightGrey,
                                onChanged: (double value) {},
                              ),
                              data: SliderTheme.of(context).copyWith(
                                  trackHeight: 5,
                                  thumbColor: Colors.transparent,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 0.0)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitleText(
                                    text: "13 \$",
                                    fontSize: 12,
                                    color: LightColor.orange,
                                  ),
                                  TitleText(
                                    text: product.partprice.toString() + "\$",
                                    fontSize: 12,
                                    color: LightColor.orange,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              product.isliked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: product.isliked
                                  ? LightColor.red
                                  : LightColor.background,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
