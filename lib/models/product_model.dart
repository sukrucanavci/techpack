import 'package:flutter/cupertino.dart';

@immutable
class ProductModel {
  final String title;
  final String category;
  final num price;
  final String vendor;
  final int id;
  final String image;

  const ProductModel(
      {required this.title,
      required this.category,
      required this.price,
      required this.vendor,
      required this.id,
      required this.image});

  factory ProductModel.fromJson(Map<String, dynamic> product) {
    return ProductModel(
        title: product["title"],
        category: product["category"],
        price: product["price"],
        vendor: product["vendor"],
        id: product["id"],
        image: product["image"]);
  }

  // Remove the logoMap from categories widget later
  String? logoMapper(){
    final Map<String, String> logoMap = {
      "itopya": "assets/images/104314.png",
      "vatan bilgisayar": "assets/images/Vatan_Computer.jpg",
      "teknosa": "assets/images/TEKnosa.png",
      "media markt": "assets/images/Media_Markt_red_textmark.png"
    };
    return logoMap[vendor];
  }
}
