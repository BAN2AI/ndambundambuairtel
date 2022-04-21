import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/pages/login.dart';
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/providers/local.dart';
import 'package:flutter_ecommerce_app/src/providers/notificationapi.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/widgets/components/default_button.dart';

class Payement extends StatefulWidget {
  final dynamic order;
  final Product product;

  const Payement({Key key, this.order, this.product}) : super(key: key);
  @override
  _PayementState createState() => _PayementState();
}

class _PayementState extends State<Payement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: LightColor.orange,
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/wallp.jpg"), fit: BoxFit.fill)),
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 0),
              color: LightColor.orange.withOpacity(.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text("Payer votre premiere tranche",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              '\$ ' + widget.order['par_tranches'].toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Totale : \$ " + widget.order['totale'].toString(),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
        ],
      ),
    );
  }

  Widget buildName(String user) => Column(
        children: [
          Text(
            "user.name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "user.email",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => DefaultButton(
        text: 'Payer',
        press: () {
          showDialog(
            context: context,
            builder: (_) => FunkyOverlay(),
          );
          Provider()
              .placeCommande(widget.order, widget.product)
              .then((value) => {
                    Navigator.of(context).pop(),
                    print(value),
                    if (value["data"] == "")
                      {showAlertDialog(context)}
                    else
                      {
                        // NotificationApi.ShowNotification(
                        //     title: "Payement effectuer avec succee",
                        //     body:
                        //         "Vous avez fait un paiement de d'une premiere tranche pour " +
                        //             widget.product.name +
                        //             " de " +
                        //             widget.order['tranche'],
                        //     payload: ""),

                        NotificationApi.ShowScheduleNotification(
                            title: "Rappel de payement",
                            body: "Vous avez fait un paiement de " +
                                (widget.order['totale'] -
                                        double.parse(widget.order['tranche']))
                                    .toString() +
                                " \$ en souffrance pour" +
                                widget.product.name,
                            dateSc: DateTime.now().add(Duration(seconds: 20)),
                            payload: ""),
                        showSuccessAlertDialog(context),
                      }
                  });
        },
      );

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

  showSuccessAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Revenir a l'acceuil"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainPage()),
            (Route<dynamic> route) => false);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Felicitation"),
      content: Text("Votre premier payement est valider"),
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

  Widget buildAbout(String user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "user.about",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key key,
    this.imagePath,
    this.isEdit = false,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage("https://picsum.photos/id/237/200/300");

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
