import 'package:flutter/material.dart';
import 'package:techpack/components/product_page.dart';

import '../authentication/auth.dart';
import '../models/product_model.dart';


class pastBaskets extends StatefulWidget {

  final List<Map<String, dynamic>> baskets;
  const pastBaskets({super.key, required this.baskets});

  @override

  State<pastBaskets> createState() => _pastBaskets();
}
class _pastBaskets extends State<pastBaskets> {
  Map<String, dynamic> quantityMap = {};

  @override

  Widget _buildCard(Map<String, dynamic> pastbasket) {
    print(pastbasket["content"]);
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5)
                ],
                color: Colors.white),
            child: Column(
              children: [
                 /*Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(pastbasket["content"]["product"]["title"].toString()),
                          fit: BoxFit.contain)),
                ),*/
                const SizedBox(height: 6),
                Text(
                  "${(pastbasket["total"].toString())} ₺",
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "${(pastbasket["timestamp"].toString())} ₺",
                    style:
                    const TextStyle(color: Colors.deepPurple, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    "${(pastbasket["total"].toString())} ₺",
                    style:
                    const TextStyle(color: Colors.deepPurple, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),

                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Past Baskets",
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
        Expanded(
        child: ListView(
        children: [
          for(final entry in widget.baskets) _buildCard(entry),
    ],
    )),]
      )
    );
  }
}


























