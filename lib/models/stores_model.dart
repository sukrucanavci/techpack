import 'package:flutter/foundation.dart';

@immutable
class StoreModel {
  final String name; // mağaza adı
  final double latitude; // enlem
  final double longitude; // boylam

  const StoreModel(
      {required this.name, required this.latitude, required this.longitude});

  factory StoreModel.fromJson(Map<String, dynamic> store) {
    return StoreModel(
        name: store["title"],
        latitude: store["category"],
        longitude: store["price"]);
  }
}
