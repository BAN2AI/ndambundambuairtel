import 'dart:collection';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Provider {
  String host = "https://ndambundambu-production.up.railway.app/items/";
  String hostn = "https://ndambundambu-production.up.railway.app/";

  Future<dynamic> verifyUserLocal() async {
    return await SharedPreferences.getInstance();
  }

  Future addPanier(product) async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> data = List();
    if (prefs.getString('panier') != null) {
      var res = json.decode(prefs.getString('panier'));
      res.forEach((element) {
        data.add(element);
      });
      data.add(product);
      // this.panier = data.length;
      prefs.setString("panier", json.encode(data));
    } else {
      data.add(product);
      prefs.setString("panier", json.encode(data));
    }
  }

  Future checkProductPanier(product) async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> data = List();
    if (prefs.getString('panier') != null) {
      var res = json.decode(prefs.getString('panier'));
      res.forEach((element) {
        // if (element['id'] == ) {

        // }
        data.add(element);
      });
      data.add(product);
    } else {
      data.add(product);
      prefs.setString("panier", json.encode(data));
    }
  }

  getPanierNbr() async {
    final prefs = await SharedPreferences.getInstance();
    // List<Map<String, dynamic>> data;
    if (prefs.getString('panier') != null) {
      dynamic res = json.decode(prefs.getString('panier'));
      int nb = 0;

      print(res.toString());
      res.forEach((element) {
        nb++;
      });
      return nb;
    } else {
      return 0;
    }
  }

  setValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    // this.getDatabase().setItem(key, value);
  }

  getUserLocal() async {
    final prefs = await SharedPreferences.getInstance();
    var res = json.decode(prefs.getString('user'));
    // prefs.remove('panier');
    return res;
  }

  getAlreadyOpened() async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.containsKey('opened');
    return res;
  }

  setAlreadyOpened() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('opened', "yes");
  }

  setDataUrl(String value) {
    return Uri.parse(host + value);
  }

  getUrl() {
    return this.host;
  }

  Future loginUser(String number, String password) async {
    var response = await http.get(this.setDataUrl(
        "/users?filter[phone_number][_eq]=" +
            Uri.encodeComponent(number) +
            "&" +
            "[password][_eq]=" +
            Uri.encodeComponent(password)));
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];

      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  Future addUser(
    String number,
    String username,
    String password,
  ) async {
    // var request = await http.MultipartRequest("POST", setDataUrl("/users"));

    // request.fields['phone_number'] = number;
    // request.fields['username'] = username;
    // request.fields['password'] = password;
    // request.fields['status'] = 'published';
    var response = await http.post(this.setDataUrl("/users"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "phone_number": number,
          "username": username,
          "password": password,
          "status": 'published'
        }));

    // request.files.add(
    //     new http.MultipartFile.fromBytes('permis', await permis.readAsBytes()));

    // var streamedResponse = await request.send();
    // var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  Future getProducts(String filter) async {
    var response = await http
        .get(this.setDataUrl("product?fields=*,category.name&sort=-" + filter));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  Future getProductsByCategorie(String filter) async {
    var response = await http.get(this.setDataUrl(
        "product?fields=*,category.name&filter[category][_eq]=" + filter));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print("this is filter \n\n");
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  Future getCommandes() async {
    var user = await this.getUserLocal();
    // dynamic users = json.decode(user);
    print(user);

    // print('users : ' + users['id_utilisateur']);
    var url = "/order?filter[iduser][_eq]=" + user['id'];
    var response = await http.get(this.setDataUrl(url));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print("COmmandes");

      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  Future sendcommandes(commandes) async {
    var response = await http.get(this.setDataUrl("name=liste&categ=produits"));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  setUser(r) {
    setValue('user', convert.jsonEncode(r));
  }

  placeCommande(dynamic order, Product product) async {
    dynamic user = await getUserLocal();
    dynamic body = json.encode({
      "product_id": product.id,
      "quantite": order['quantite'],
      "tranche": order['tranche'],
      "Total": order['totale'],
      "par_tranches": order['par_tranches'],
      "priceselected": order['price'],
      "istranche": true,
      "status": "published",
      "iduser": user['id']
    });
    print(body);
    var response = await http.post(this.setDataUrl("order"),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body.toString()}.');
      return [];
    }
  }

  placeCommandeCart(dynamic order, dynamic product) async {
    dynamic user = await getUserLocal();
    dynamic body = json.encode({
      "product_id": product['id'],
      "quantite": product['quantite'],
      "Total": order['totale'],
      "priceselected": product['price'],
      "istranche": false,
      "status": "published",
      "iduser": user['id']
    });
    print(body);
    var response = await http.post(this.setDataUrl("order"),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body.toString()}.');
      return [];
    }
  }

  void removePanier() async {
    final prefs = await SharedPreferences.getInstance();
    // var res = json.decode(prefs.getString('user'));
    prefs.remove('panier');
  }

  getSlider() async {
    var response = await http.get(this.setDataUrl("/Slider"));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');

      return [];
    }
  }

  getCategories() async {
    var response = await http.get(this.setDataUrl("/category"));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  getHost() {
    return hostn;
  }

  getProductById(id) async {
    print("voici l'id du produit " + id);
    var response = await http.get(this
        .setDataUrl("product?fields=*,category.name&filter[id][_eq]=" + id));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print("product by id");
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  getPanier() async {
    final prefs = await SharedPreferences.getInstance();
    // List<Map<String, dynamic>> data;
    if (prefs.getString('panier') != null) {
      dynamic res = json.decode(prefs.getString('panier'));
      int nb = 0;

      print(res.toString());

      return res;
    } else {
      return 0;
    }
  }

  getProductsbyName(String keyword) async {
    print("voici l'id du produit " + keyword);
    var response = await http.get(
        this.setDataUrl("product?fields=*,category.name&search=" + keyword));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print("product by id");
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  getWishList() async {
    var user = await this.getUserLocal();
    // dynamic users = json.decode(user);
    print(user);

    // print('users : ' + users['id_utilisateur']);
    var url = "/Wishlist?filter[iduser][_eq]=" + user['id'];
    var response = await http.get(this.setDataUrl(url));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print("COmmandes");

      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  placeCommandeAll(order, List<dynamic> product) async {
    List<Future> fn = [];
    product.forEach((element) {
      fn.add(placeCommandeCart(order, element));
    });
    Future.wait(fn).then((List responses) => responses).catchError((e) => e);
  }
}
