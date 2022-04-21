import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';

class ProductCard2 extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;
  ProductCard2({Key key, this.product, this.onSelected}) : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   Product product;
//   @override
//   void initState() {
//     product = widget.product;
//     super.initState();
//   }

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
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(
                    product.isliked ? Icons.favorite : Icons.favorite_border,
                    color: product.isliked
                        ? LightColor.red
                        : LightColor.background,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ));
  }
}
