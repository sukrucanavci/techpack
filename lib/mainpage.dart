import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Padding(
        padding:const EdgeInsets.all(25.0),
        child:Column (
          mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Image.asset('assets/logo.jpg'),
              Container(
                width:300.0,
              child:TextField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0),
              border:GradientOutlineInputBorder(
                width: 3.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(
                      colors:[Colors.deepPurpleAccent, Colors.purple])),
        ),),
              )


  ]

      )
     )
    );
  }
}