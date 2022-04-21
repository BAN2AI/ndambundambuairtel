import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/category.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';

class AppData {
  static List<Product> productList = [
    Product(
        id: 3,
        name: 'Place concert Hugo Kafumbi',
        price: 24.00,
        isSelected: false,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/FGvnbt9XEAYkX2M.jpeg',
        category: "events"),
    Product(
        id: 1,
        name: 'Voyage pour paris',
        price: 24.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/paris.jpeg',
        category: "voyage"),
    Product(
        id: 2,
        name: 'Billet pour kin',
        price: 20.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/kinshassa.jpg',
        category: "voyage"),
    Product(
        id: 2,
        name: 'Billets d\'avion RDC-TANZANIE',
        price: 22.00,
        familyprice: 200.00,
        partprice: 280.00,
        isliked: false,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/70.jpg',
        category: "billet"),
  ];

  static List<Product> productListHouse = [
    Product(
        id: 1,
        name: 'Bureaux a louer',
        price: 24.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/immaos bureaux.jpeg',
        category: "Bureaux"),
    Product(
        id: 2,
        name: 'Bureaux a louer',
        price: 20.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        image: 'assets/maison.jpeg',
        category: "Maison"),
    Product(
        id: 3,
        name: 'Appartement de louer',
        price: 20.00,
        isSelected: false,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/2015-08-7-12-08-50_sam_0319_640_640_0.jpg',
        category: "studio"),
  ];

  static List<Product> productListElectro = [
    Product(
        id: 1,
        name: 'Machine a laver',
        price: 240.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/5a26af56087102040a95d494.png',
        category: "Electromenager"),
    Product(
        id: 2,
        name: 'Frigo refregirateur',
        price: 220.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/585fd01acb11b227491c35cc.png',
        category: "Electromenager"),
    Product(
        id: 3,
        name: 'Micro Ondes',
        price: 240.00,
        isSelected: false,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/5b51f0fbc051e602a568ce68.png',
        category: "events"),
  ];

  static List<Product> cartList = [
    Product(
        id: 1,
        name: 'Sofa De salon dou',
        price: 240.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/10-2-sofa-free-png-image.png',
        category: "meuble"),
    Product(
        id: 2,
        name: 'Sofa de salon rouge',
        price: 220.00,
        isliked: false,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        familyprice: 200.00,
        partprice: 280.00,
        image: 'assets/923-9230147_sofa-png-image-png-images-of-sofa-set.png',
        category: "meuble"),
    Product(
        id: 1,
        name: 'Sofa De salon dou',
        price: 240.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/10-2-sofa-free-png-image.png',
        category: "meuble"),
    Product(
        id: 2,
        name: 'Sofa de salon rouge',
        price: 220.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/923-9230147_sofa-png-image-png-images-of-sofa-set.png',
        category: "meuble"),
    Product(
        id: 1,
        name: 'Sofa De salon dou',
        price: 240.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/10-2-sofa-free-png-image.png',
        category: "meuble"),
    Product(
        id: 2,
        name: 'Sofa de salon rouge',
        price: 220.00,
        isliked: false,
        familyprice: 200.00,
        partprice: 280.00,
        description:
            'Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey',
        image: 'assets/923-9230147_sofa-png-image-png-images-of-sofa-set.png',
        category: "meuble"),
  ];
  static List<Category> categoryList = [
    Category(
        id: 2, name: "Voyage", icon: Icons.airplanemode_on, isSelected: true),
    Category(id: 3, name: "Conference", icon: Icons.people),
    Category(id: 1, name: "Evennement", icon: Icons.event_available_rounded),
    Category(id: 4, name: "Sorties", icon: Icons.add_road),
  ];

  static List<Category> categoryListHome = [
    Category(id: 5, name: "Appartement", icon: Icons.room, isSelected: true),
    Category(id: 6, name: "Maison", icon: Icons.house),
    Category(id: 8, name: "Bureau", icon: Icons.business)
  ];

  static List<Category> categoryListElectronmenager = [
    Category(id: 1, name: "Appartement", icon: Icons.room, isSelected: true),
    Category(id: 2, name: "Maison", icon: Icons.house),
    Category(id: 3, name: "Bureau", icon: Icons.business)
  ];

  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.png",
    "assets/shoe_thumb_1.png",
    "assets/shoe_thumb_4.png",
    "assets/shoe_thumb_3.png",
  ];
  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
