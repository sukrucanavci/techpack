import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:techpack/components/customCard.dart';
import 'package:techpack/models/product_model.dart';
import 'package:techpack/pages/map.dart';
import 'package:path/path.dart' as Path;
import '../models/stores_model.dart';

class Routes extends StatefulWidget {
  const Routes({super.key, required this.products, required this.totalPrice});

  final List<ProductModel> products;
  final double totalPrice;

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  late Position _currentPosition;

  List<Store> stores = [];
  List<String> storeNamelist = [];
  List<Store> closestStores = [];

  _findStoreNames() {
    for (var product in widget.products) {
      if (storeNamelist.contains(product.vendor) == false) {
        storeNamelist.add(product.vendor);
      }
    }
  }

  Future<void> _getStores() async {
    final database = openDatabase(
      Path.join(await getDatabasesPath(), 'techpack_database.db'),
    );

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('stores');

    stores = List.generate(maps.length, (i) {
      return Store(
        id: maps[i]['id'],
        name: maps[i]['name'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        address: maps[i]['address'],
      );
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition();
  }

  double _coordinateDistance(lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - _currentPosition.latitude) * p) / 2 +
        c(_currentPosition.latitude * p) *
            c(lat2 * p) *
            (1 - c((lon2 - _currentPosition.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  Store findClosestStore(String vendor) {
    double distance = 9999999;
    Store store = stores[0];

    for (var store in stores) {
      if (store.name.contains(vendor)) {
        var storeDistance =
            _coordinateDistance(store.latitude, store.longitude);
        if (storeDistance <= distance) {
          distance = storeDistance;
          store = store;
        }
      }
    }
    return store;
  }

  _determineClosestStores() {
    for (var storeName in storeNamelist) {
      closestStores.add(findClosestStore(storeName));
    }
  }

  @override
  void initState() {
    /*
    _findStoreNames();
    _determinePosition();
    _getStores().then((value) => {_determineClosestStores()});
    */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Rotalar",
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            RouteCard(
              tutar: "${widget.totalPrice} TL",
              mesafe: "3164 m",
              yuksekMi: false,
            ),
            RouteCard(
              tutar: "18.412 TL",
              mesafe: "1596 m",
              yuksekMi: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(12),
        child: TextButton(
          child: Text('Haritada Gör'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapPage(
                        storeLocations: closestStores,
                      )),
            );
          },
        ),
      ),
    );
  }
}
