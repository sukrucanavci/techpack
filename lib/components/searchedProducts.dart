import 'package:flutter/material.dart';
import 'package:techpack/components/product_page.dart';


class SearchedProducts extends StatefulWidget {
  const SearchedProducts({super.key});

  @override
  State<SearchedProducts> createState() => _SearchedProductsState();
}

class _SearchedProductsState extends State<SearchedProducts>

    with SingleTickerProviderStateMixin {

  @override

  Widget build(BuildContext context) {

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(left: 20),
        children: [
          const Text("Results",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple)),
          const SizedBox(height: 15),

          Container(

            height: MediaQuery.of(context).size.height -100,
            width: double.infinity,
            child:

              ProductPage(category:"search"),
          )
        ],
      ),
    );
  }
}
