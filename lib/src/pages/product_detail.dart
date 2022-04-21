import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/pages/payement.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/widgets/components/default_button.dart';
import 'package:flutter_ecommerce_app/src/widgets/title_text.dart';
import 'package:flutter_ecommerce_app/src/widgets/extentions.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quantity_input/quantity_input.dart';

class ProductDetailPage extends StatefulWidget {
  final Product pr;
  ProductDetailPage({Key key, this.pr}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  var prefs;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    this.startSharedPreference();
  }

  startSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;
  int _isSelected = 0;
  bool select = false;
  int number = 0;
  int simpleinput = 1;
  TextEditingController tranches = new TextEditingController();

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? LightColor.red : LightColor.lightGrey,
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          }),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = LightColor.iconColor,
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    Function onPressed,
  }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
            isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage() {
    return AnimatedBuilder(
        builder: (context, child) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: animation.value,
            child: child,
          );
        },
        animation: animation,
        child: Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.pr.image),
                    fit: BoxFit.fitHeight)),
            child: Text(""))

        // Stack(
        //   alignment: Alignment.bottomCenter,
        //   children: <Widget>[Image.asset(widget.pr.image)],
        // ),
        );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()),
    );
  }

  Widget _thumbnail(String image) {
    return AnimatedBuilder(
      animation: animation,
      //  builder: null,
      builder: (context, child) => AnimatedOpacity(
        opacity: animation.value,
        duration: Duration(milliseconds: 500),
        child: child,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: LightColor.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(13)),
            // color: Theme.of(context).backgroundColor,
          ),
          child: Image.asset(image),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13))),
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: TitleText(text: widget.pr.name, fontSize: 25)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: getPrice().toString(),
                                fontSize: 25,
                              ),
                              TitleText(
                                text: "\$ ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star,
                                  color: LightColor.yellowColor, size: 17),
                              Icon(Icons.star_border, size: 17),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _description(),
                SizedBox(
                  height: 20,
                ),
                _availableSize(),
                select
                    ? Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _sizeWidget("Accompte", 3,
                              isSelected: _isSelected == 3 ? true : false),
                          _sizeWidget("Cash", 4,
                              isSelected: _isSelected == 4 ? true : false),
                        ],
                      )
                    : Text(""),
                _isSelected == 3
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          TitleText(
                            text: "Votre premier Accompte",
                            fontSize: 14,
                          ),
                          TextField(
                            controller: tranches,
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                hintText: 'En ', prefixText: "\$"),
                          )
                        ]))
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                TitleText(
                  text: "Quantites",
                  fontSize: 14,
                ),
                SizedBox(height: 20),
                QuantityInput(
                    label: '',
                    value: simpleinput,
                    buttonColor: LightColor.orange,
                    onChanged: (value) => setState(() =>
                        simpleinput = int.parse(value.replaceAll(',', '')))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Choisissez un prix",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _sizeWidget("Prix famille", 1,
                isSelected: _isSelected == 1 ? true : false),
            _sizeWidget("Prix Individuel", 2,
                isSelected: _isSelected == 2 ? true : false),
          ],
        )
      ],
    );
  }

  double getPrice() {
    if (_isSelected == 1) {
      return widget.pr.familyprice;
    } else if (_isSelected == 2) {
      return widget.pr.partprice;
    } else if (_isSelected == 3) {
      return widget.pr.partprice;
    } else {
      return widget.pr.price;
    }
  }

  Widget _sizeWidget(String text, int intiger, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
            isSelected ? LightColor.orange : Theme.of(context).backgroundColor,
      ),
      child: TitleText(
        text: text,
        fontSize: 16,
        color: isSelected ? LightColor.background : LightColor.titleTextColor,
      ),
    ).ripple(() {
      setState(() {
        _isSelected = intiger;
        select = true;
      });
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Size",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorWidget(LightColor.yellowColor, isSelected: true),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.lightBlue),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.black),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.red),
            SizedBox(
              width: 30,
            ),
            _colorWidget(LightColor.skyBlue),
          ],
        )
      ],
    );
  }

  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(
              Icons.check_circle,
              color: color,
              size: 18,
            )
          : CircleAvatar(radius: 7, backgroundColor: color),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Description",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(widget.pr.description),
      ],
    );
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {
        if (int.parse(tranches.text) > (getPrice() * simpleinput)) {
          showInfosDialog(
              context, "Votre Accompte est superieur aux prix du produit");
        } else {
          _settingModalBottomSheet(context);
        }
      },
      backgroundColor: LightColor.orange,
      child: Icon(Icons.shopping_basket,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: [
                      _productImage(),
                      _appBar(),
                    ],
                  ),
                  _categoryWidget(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13))),
              child: Column(
                children: [
                  Text("Resumer", style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: LightColor.lightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(widget.pr.image),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListTile(
                          title: TitleText(
                            text: widget.pr.name,
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
                                text: getPrice().toString(),
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(
                        text: 'Quantites',
                        color: LightColor.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      TitleText(
                        text: '$simpleinput',
                        fontSize: 18,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isSelected == 3
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TitleText(
                              text: 'Premier tranche',
                              color: LightColor.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            TitleText(
                              text: tranches.text + ' \$',
                              fontSize: 18,
                            ),
                          ],
                        )
                      : Text(""),
                  SizedBox(
                    height: 20,
                  ),
                  // _isSelected == 3
                  //     ? Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: <Widget>[
                  //           TitleText(
                  //             text: 'Par Tranches',
                  //             color: LightColor.grey,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //           TitleText(
                  //             text: '\$ ' +
                  //                 ((getPrice() * simpleinput) /
                  //                         int.parse(tranches.text))
                  //                     .toString(),
                  //             fontSize: 18,
                  //           ),
                  //         ],
                  //       )
                  //     : Text(""),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(
                        text: 'Totale',
                        color: LightColor.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      TitleText(
                        text: '\$ ' + (getPrice() * simpleinput).toString(),
                        fontSize: 18,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isSelected == 3
                      ? DefaultButton(
                          text: "Payer",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payement(
                                          product: widget.pr,
                                          order: {
                                            'tranche': tranches.text,
                                            'totale': getPrice() * simpleinput,
                                            'par_tranches': tranches.text,
                                            'price': getPrice(),
                                            'quantite': simpleinput
                                          },
                                        )));
                          },
                        )
                      : Container(),
                  _isSelected == 4
                      ? DefaultButton(
                          text: "Ajouter au panier",
                          press: () {
                            Navigator.of(context).pop();
                            Provider().addPanier({
                              "id": widget.pr.id,
                              "category": widget.pr.category,
                              "description": widget.pr.description,
                              "isliked": false,
                              "quantite": simpleinput,
                              "name": widget.pr.name,
                              "price": getPrice(),
                              "familyprice": widget.pr.familyprice,
                              "familypartprice": widget.pr.familyprice,
                              "partprice": widget.pr.partprice,
                              "isSelected": true,
                              "image": widget.pr.image
                            });

                            showAlertDialog(context);
                          },
                        )
                      : Container()
                ],
              ));
        });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainPage()),
            (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Produits ajouter au panier"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showInfosDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
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
