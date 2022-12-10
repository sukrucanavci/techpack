// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;
import '../models/stores_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.storeLocations});
  final List<Store> storeLocations;

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
  bool isLoading = false;
  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  Future<CameraPosition> findCenter() async {
    double lat = 0;
    double lng = 0;

    for (var i = 0; i < widget.storeLocations.length; ++i) {
      lat += double.parse(widget.storeLocations[i].latitude);
      lng += double.parse(widget.storeLocations[i].longitude);
    }

    lat /= (widget.storeLocations.length);
    lng /= (widget.storeLocations.length);

    return CameraPosition(target: LatLng(lat, lng), zoom: 0.5);
  }

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

      for (int index = 0; index < widget.storeLocations.length - 1; index++) {
        var startLat = double.parse(widget.storeLocations[index].latitude);
        var startLong = double.parse(widget.storeLocations[index].longitude);

        startMarker = Marker(
            markerId: MarkerId(index.toString()),
            position: LatLng(startLat, startLong),
            infoWindow: InfoWindow(
              title: widget.storeLocations[index].name,
              snippet: widget.storeLocations[index].address,
            ),
            icon: await _getStoreBitmapIcon(widget.storeLocations[index].name));

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
    var startLat = double.parse(widget.storeLocations[startIndex].latitude);
    var startLong = double.parse(widget.storeLocations[startIndex].longitude);
    var endLat = double.parse(widget.storeLocations[endIndex].latitude);
    var endLong = double.parse(widget.storeLocations[endIndex].longitude);

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

  _showRoute() async {
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
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: <Widget>[
                    GoogleMap(
                      markers: Set<Marker>.from(markers),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      polylines: Set<Polyline>.of(polylines.values),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          double.parse(widget.storeLocations.last.latitude),
                          double.parse(widget.storeLocations.last.longitude),
                        ),
                        zoom: 12,
                      ),
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
