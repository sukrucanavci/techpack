import 'package:flutter/material.dart';
import 'package:techpack/pages/mainpage.dart';

void main() {
  runApp(MaterialApp(
      title: "tech pack",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Mainpage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/splash.png"), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        50, 500, 10, 50)), //or const EdgeInsets.all(280.0),),
                CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
