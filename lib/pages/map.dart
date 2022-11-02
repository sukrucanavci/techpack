import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'dart:collection';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(41.0161015, 28.5618782),
    zoom: 12,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  // list of locations to display polylines
  List<LatLng> latLen = [
    LatLng(41.0049831, 28.6190673), //vatan
    LatLng(41.0161015, 28.5618782), //teknosa
    LatLng(41.0118166, 28.6458206), //media markt
  ];

  Map<String, String> names = {
    "Vatan Bilgisayar": "Avcılar",
    "Teknosa": "Avcılar",
    "MediaMarkt": "Avcılar",
  };

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < latLen.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latLen[i],
        infoWindow: InfoWindow(
          title: names.keys.elementAt(i),
          snippet: names.values.elementAt(i),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
        polylineId: PolylineId(i.toString()),
        points: latLen,
        color: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Güzergah"),
        centerTitle: false,
      ),
      body: GoogleMap(
        initialCameraPosition: _kGoogle,
        mapType: MapType.normal,
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
