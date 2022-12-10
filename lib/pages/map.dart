// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;
import '../components/gradiantText.dart';
import '../models/product_model.dart';
import '../models/stores_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.products, required this.totalPrice});
  //final List<Store> storeLocations;
  final List<ProductModel> products;
  final num totalPrice;

  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late GoogleMapController mapController;
  final Random _random = Random();

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  // ignore: unused_field
  String _placeDistance = "0";
  bool isLoading = true;
  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Future<BitmapDescriptor> _getStoreBitmapIcon(String name) async {
    if (name.contains("vatan")) {
      return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "assets/images/marker_vatan.png",
      );
    } else if (name.contains("itopya")) {
      return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "assets/images/marker_itopya.png",
      );
    } else if (name.contains("teknosa")) {
      return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "assets/images/marker_teknosa.png",
      );
    } else if (name.contains("media markt")) {
      return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        "assets/images/marker_mediamarkt.png",
      );
    }

    return BitmapDescriptor.defaultMarker;
  }

  Future<bool> _setupMarkersAndDrawPolylines() async {
    try {
      Marker startMarker;
      Marker destinationMarker;

      for (int index = 0; index < closestStores.length - 1; index++) {
        var startLat = double.parse(closestStores[index].latitude);
        var startLong = double.parse(closestStores[index].longitude);

        startMarker = Marker(
            markerId: MarkerId(index.toString()),
            position: LatLng(startLat, startLong),
            infoWindow: InfoWindow(
              title: closestStores[index].name,
              snippet: closestStores[index].address,
            ),
            icon: await _getStoreBitmapIcon(closestStores[index].name));

        markers.add(startMarker);

        await _createPolylines(index, index + 1);
      }

      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return false;
  }

  _createPolylines(int startIndex, int endIndex) async {
    var startLat = double.parse(closestStores[startIndex].latitude);
    var startLong = double.parse(closestStores[startIndex].longitude);
    var endLat = double.parse(closestStores[endIndex].latitude);
    var endLong = double.parse(closestStores[endIndex].longitude);

    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCHeCkv14TSN02WunbYwJqp4jV5etix6LM",
      PointLatLng(startLat, startLong),
      PointLatLng(endLat, endLong),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId(Random().nextInt(100).toString());

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.purple,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
  }

  Future _showRoute() async {
    startAddressFocusNode.unfocus();
    desrinationAddressFocusNode.unfocus();

    setState(() {
      if (markers.isNotEmpty) markers.clear();
      if (polylines.isNotEmpty) polylines.clear();
      if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();
      _placeDistance = "";
    });

    _setupMarkersAndDrawPolylines().then((isSuccess) {
      if (isSuccess) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Route is ready'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failure'),
          ),
        );
      }
    });
  }

  // -------------------------------------
  Position _currentPosition = Position(
      longitude: 28.7259004,
      latitude: 40.9898818,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  List<Store> stores = [];
  List<String> storeNamelist = [];
  List<Store> closestStores = [];
  double totalDistance = 0;

  Future _findStoreNames() async {
    for (var product in widget.products) {
      if (storeNamelist.contains(product.vendor) == false) {
        storeNamelist.add(product.vendor);
      }
    }
    print(storeNamelist);
  }

  Future<void> _getStores() async {
    final database = openDatabase(
      Path.join(await getDatabasesPath(), 'techpack_database.db'),
    );

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('stores');

    stores = List.generate(
      maps.length,
      (i) {
        return Store(
          id: maps[i]['id'],
          name: maps[i]['name'],
          latitude: maps[i]['latitude'],
          longitude: maps[i]['longitude'],
          address: maps[i]['address'],
        );
      },
    );
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

  double _coordinateDistance(double lat2, double lon2) {
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
    Store returnStore = stores[0];

    for (var store in stores) {
      if (store.name.contains(vendor)) {
        var storeDistance = _coordinateDistance(
            double.parse(store.latitude), double.parse(store.longitude));
        if (storeDistance < distance) {
          distance = storeDistance;
          returnStore = store;
        }
      }
    }
    setState(() {
      totalDistance += distance;
    });
    return returnStore;
  }

  Future _determineClosestStores() async {
    for (var storeName in storeNamelist) {
      closestStores.add(findClosestStore(storeName));
      print(closestStores);
    }
    closestStores.add(
      Store(
          id: 999,
          name: "Konumum",
          latitude: "${_currentPosition.latitude}",
          longitude: "${_currentPosition.longitude}",
          address: ""),
    );
  }

  //-------------------------------------------

  @override
  void initState() {
    _findStoreNames().then((value) => {
          _determinePosition().then((value) => {
                _getStores().then((value) => {
                      _determineClosestStores().then((value) => {_showRoute()})
                    })
              })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.purple,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            "Route",
            style: TextStyle(color: Colors.purple),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 60,
          elevation: 0,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: isLoading
              ? Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(color: Colors.purple),
                      SizedBox(width: 12),
                      GradientText(
                        'Loading',
                        style: TextStyle(fontSize: 26),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 73, 21, 136),
                          Color.fromARGB(255, 190, 118, 202),
                        ]),
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      markers: Set<Marker>.from(markers),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      polylines: Set<Polyline>.of(polylines.values),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          double.parse(closestStores.last.latitude),
                          double.parse(closestStores.last.longitude),
                        ),
                        zoom: 8,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                        Timer(Duration(seconds: 1), () {
                          mapController
                              .animateCamera(CameraUpdate.zoomTo(11.5));
                        });
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
