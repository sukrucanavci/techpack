import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:techpack/pages/categories.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 320.0, top: 50),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_basket,
                                color: Colors.purple),
                            tooltip: 'Sepeti görüntüle'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150),
            Image.asset('assets/logo.jpg'),
            Container(
              width: 300.0,
              child: TextField(
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Categories()),
                  );
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                  border: GradientOutlineInputBorder(
                      width: 3.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.purple])),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 12, fontStyle: FontStyle.normal),
                shadowColor: Colors.purple,
              ),
              label: const Text('Geçmiş Sepetler',
                  style: TextStyle(color: Colors.purple)),
              icon: const Icon(
                Icons.shopping_basket_outlined,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
