import 'package:flutter/material.dart';
import 'package:techpack/components/customCard.dart';
import 'package:techpack/pages/map.dart';

class Routes extends StatefulWidget {
  const Routes({super.key, required this.title});

  final String title;

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Rotalar"),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          children: [
            RouteCard(
              tutar: "16.388 TL",
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
              MaterialPageRoute(builder: (context) => MapPage()),
            );
          },
        ),
      ),
    );
  }
}
