import 'package:flutter/material.dart';
import 'package:techpack/components/customCard.dart';
import 'package:techpack/pages/map.dart';

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tech pack',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'tech pack'),
    );
  }
}
*/

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            SepetEsyasi(
              tutar: "16.388 TL",
              mesafe: "3164 m",
              yuksekMi: false,
            ),
            SepetEsyasi(
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
