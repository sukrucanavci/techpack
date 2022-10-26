import 'package:flutter/material.dart';
import 'package:techpack/mainpage.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Mainpage()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit:StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/splash.png"),
                    fit: BoxFit.cover)),

          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 500, 10, 50)), //or const EdgeInsets.all(280.0),),
                CircularProgressIndicator(
                  color:Colors.deepPurple,
                ),
            ],
          ),
          )
        ],
    ),

    );
  }
}
