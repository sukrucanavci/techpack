
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/product_model.dart';
import '../pages/map.dart';
class pastBasketsDetail extends StatefulWidget {

  final Map<String, dynamic> basket;

  const pastBasketsDetail({super.key, required this.basket});
  @override
  State<StatefulWidget> createState() => _pastBasketsDetail();

  }

class _pastBasketsDetail extends State<pastBasketsDetail> {
  @override

  List <ProductModel> allResults=[];
  bool isLoadingActive = false;
  void initState() {

    for (final entry in widget.basket["content"])
    {
      allResults.add(_buildmodel(entry));
    }
    super.initState();

  }

  ProductModel _buildmodel(Map<String, dynamic> content) {

    return ProductModel(
        title: content["product"]["title"],
        category: content["product"]["category"],
        price: content["product"]["price"],
        vendor: content["product"]["vendor"],
        id: content["product"]["id"],
        image: content["product"]["image"]);
  }


  Widget _buildCard(Map<String, dynamic> pastbasket) {
    return Container(
        margin: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5)
            ],
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (pastbasket["product"]["category"].toString() == "search"
                            ? NetworkImage(pastbasket["product"]["image"].toString())
                            : AssetImage(pastbasket["product"]["image"].toString()) as ImageProvider),
                        fit: BoxFit.contain),
                ),
        ),

              Container(
                padding: EdgeInsets.only(left: 10),
                width: 150,
                child: Column(
                  children: [
                    Text(
                      pastbasket["product"]["title"].toString().length>=50 ? "${pastbasket["product"]["title"].toString().substring(0,50)}..." : pastbasket["product"]["title"].toString(),
                      style: const TextStyle(
                          color: Colors.deepPurple, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${pastbasket["product"]["price"].toString()} ₺",
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              )
            ],
    ),
            Column(
              children: [
                Container(
                  height: 70,
                  width: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (pastbasket["product"]["vendor"].toString() == "teknosa"
                              ? const AssetImage("assets/images/TEKnosa.png")
                              : ((pastbasket["product"]["vendor"].toString() == "vatan"
                                  ? const AssetImage("assets/images/Vatan_Computer.jpg")
                                  : const AssetImage("assets/images/104314.png")))
                          ),

                          fit: BoxFit.contain)),
                ),
              ],
            )
          ],
        ),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
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
          "Past Cart Detail",
          style: TextStyle(color: Colors.purple),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 0,
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView(
                children: [
                  for(
                  final entry in widget.basket["content"])
                    _buildCard(entry),
                ],
              ),
            ),
           Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapPage(products:allResults),
                      ),
                  );
                },
                backgroundColor: Colors.deepPurple,
                child: const Icon(Icons.map_outlined),
              ),
            )
          ],
        ),
    );
  }
}



























































































































