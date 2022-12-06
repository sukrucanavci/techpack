import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import '../models/stores_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPage> {
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(40.9898818, 28.7259004));
  late GoogleMapController mapController;

  late Position _currentPosition;
  String _currentAddress = "";

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _placeDistance = "0";

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Future<CameraPosition> findCenter() async {
    double lat = 0;
    double lng = 0;

    for (var i = 0; i < storeLocations.length; ++i) {
      lat += double.parse(storeLocations[i].latitude);
      lng += double.parse(storeLocations[i].longitude);
    }

    lat /= (storeLocations.length);
    lng /= (storeLocations.length);

    return CameraPosition(target: LatLng(lat, lng), zoom: 0.5);
  }

  List<Store> storeLocations = [
    Store(
        id: 18,
        name: "İstanbul İsti̇nye Park Exxtra",
        latitude: "41.10996",
        longitude: "29.03223",
        address:
            "Pınar Mahallesi İstinye Bayırı Cad. İstinye Park Alışveriş Merkezi No:73 Mgz No: L206 - L208, 34460 İSTİNYE MAH SARIYER İstanbul TR"),
    Store(
        id: 19,
        name: "İstanbul Levent Metrocity Extra Yeni̇",
        latitude: "41.07615",
        longitude: "29.01295",
        address:
            "Büyükdere Cad. N0 171 Metrocity Avm Kat-1 LEVENT MAH BEŞİKTAŞ İstanbul TR"),
    Store(
        id: 16,
        name: "İstanbul Eti̇ler Akmerkez",
        latitude: "41.07690152089097",
        longitude: "29.026803907270917",
        address:
            "İstanbul Nispetiye Caddesi Akmerkez Avm 418-419 nolu mağaza ETİLER MAH BEŞİKTAŞ İstanbul TR"),
    Store(
        id: 14,
        name: "İstanbul Altuni̇zade Capitol",
        latitude: "41.02086",
        longitude: "29.03943",
        address:
            "Mahiriz Cad. Capitol Avm No:71 ALTUNİZADE MAH ÜSKÜDAR İstanbul TR")
  ];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

  Future<bool> _calculateDistance() async {
    try {
      Marker startMarker;
      Marker destinationMarker;

      for (int index = 0; index < storeLocations.length - 1; index++) {
        var startLat = double.parse(storeLocations[index].latitude);
        var startLong = double.parse(storeLocations[index].longitude);
        var endLat = double.parse(storeLocations[index + 1].latitude);
        var endLong = double.parse(storeLocations[index + 1].longitude);

        startMarker = Marker(
          markerId: MarkerId(index.toString()),
          position: LatLng(
            startLat,
            startLong,
          ),
          infoWindow: InfoWindow(
            title: storeLocations[index].name,
            snippet: storeLocations[index].address,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        destinationMarker = Marker(
          markerId: MarkerId((index + 1).toString()),
          position: LatLng(
            endLat,
            endLong,
          ),
          infoWindow: InfoWindow(
            title: storeLocations[index + 1].name,
            snippet: storeLocations[index + 1].address,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        markers.add(startMarker);
        markers.add(destinationMarker);

        await _createPolylines(index, index + 1);
      }

      /*double miny = (startLat <= endlat)
          ? storeLocations[0].latitude
          : storeLocations[1].latitude;
      double minx = (storeLocations[0].longitude <= storeLocations[1].longitude)
          ? storeLocations[0].longitude
          : storeLocations[1].longitude;
      double maxy = (storeLocations[0].latitude <= storeLocations[1].latitude)
          ? storeLocations[1].latitude
          : storeLocations[0].latitude;
      double maxx = (storeLocations[0].longitude <= storeLocations[1].longitude)
          ? storeLocations[1].longitude
          : storeLocations[0].longitude;

      *mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(
              maxy,
              maxx,
            ),
            southwest: LatLng(
              miny,
              minx,
            ),
          ),
          100.0,
        ),
      );*/

      /*double totalDistance = 0.0;

      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });*/

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _createPolylines(int startIndex, int endIndex) async {
    var startLat = double.parse(storeLocations[startIndex].latitude);
    var startLong = double.parse(storeLocations[startIndex].longitude);
    var endLat = double.parse(storeLocations[endIndex].latitude);
    var endLong = double.parse(storeLocations[endIndex].longitude);

    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDnUcpB4pSoX9ge_vg7s4uU6k3zm0SILQU",
      PointLatLng(startLat, startLong),
      PointLatLng(endLat, endLong),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.purple,
      points: polylineCoordinates,
      width: 6,
    );
    polylines[id] = polyline;
    setState(() {});
    setState(() {
      mapController
          .moveCamera(CameraUpdate.newCameraPosition(_initialLocation));
    });
  }

  _showRoute() async {
    _initialLocation = await findCenter();

    print(await stores());

    startAddressFocusNode.unfocus();
    desrinationAddressFocusNode.unfocus();
    setState(() {
      if (markers.isNotEmpty) markers.clear();
      if (polylines.isNotEmpty) polylines.clear();
      if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();
      _placeDistance = "";
    });

    _calculateDistance().then((isCalculated) {
      if (isCalculated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Başarılı'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hata'),
          ),
        );
      }
    });
  }

  Future<List<Store>> stores() async {
    final database = openDatabase(
      Path.join(await getDatabasesPath(), 'techpack_database.db'),
    );

    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('stores');

    return List.generate(maps.length, (i) {
      return Store(
        id: maps[i]['id'],
        name: maps[i]['name'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        address: maps[i]['address'],
      );
    });
  }

  @override
  void initState() {
    //_createPolylines();

    super.initState();
    //_getCurrentLocation();
    //_showRoute();
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
            "Selected Route",
            style: TextStyle(color: Colors.purple),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 60,
          elevation: 0,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              // Map View
              GoogleMap(
                markers: Set<Marker>.from(markers),
                initialCameraPosition: _initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                polylines: Set<Polyline>.of(polylines.values),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  _showRoute();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
