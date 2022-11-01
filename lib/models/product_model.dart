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
}
