
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../components/pastBasketsDetail.dart';



class pastBaskets extends StatefulWidget {

  final List<Map<String, dynamic>> baskets;
  const pastBaskets({super.key, required this.baskets});

  @override

  State<pastBaskets> createState() => _pastBaskets();
}
class _pastBaskets extends State<pastBaskets> {
  bool selected = false;
  Map<String, dynamic> quantityMap = {};

  Widget _buildCard(Map<String, dynamic> pastbasket) {

    String datetime =  "${pastbasket["timestamp"].day}/${pastbasket["timestamp"].month}/${pastbasket["timestamp"].year}";
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.black26, width: 2),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                selected = !selected;
              },
              );
            },

            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(
                        "$datetime ",
                        style:
                        const TextStyle(color: Colors.deepPurple, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Tutar : ${(pastbasket["total"].toString())} ₺",
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                  ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for(int i =0; i<2;i++)
                        _buildimages( pastbasket["content"][i]), //for(final entry in pastbasket["content"]) ,
                     Text(
                         (pastbasket["content"].length) > 3
                             ? "+ ${pastbasket["content"].length -2}"
                             : " ",
                       style: const TextStyle(
                           color: Colors.deepPurple,
                           fontSize: 14,
                           fontWeight: FontWeight.bold),)
                     // if (pastbasket["content"].length)

                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => pastBasketsDetail(basket: pastbasket)));
                          },
                          child: const Padding(
                        padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Detay >>",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildimages(Map<String, dynamic> content) {
    return Container(
      height: 60,
      width: 80,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: (content["product"]["category"].toString() == "search"
                  ? NetworkImage(
                  content["product"]["image"].toString())
                  : AssetImage(
                  content["product"]["image"].toString()) as ImageProvider),
              fit: BoxFit.contain)),
    );
  }
  @override
  Widget build(BuildContext context) {

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
            ),
          ),
        ],
      ),
    );
  }
}







































































































































