import 'package:flutter/material.dart';
import 'package:techpack/components/product_page.dart';

import '../authentication/auth.dart';


class pastBaskets extends StatefulWidget {
  final List<Map<String, dynamic>> baskets;
  const pastBaskets({super.key, required this.baskets});

  @override
  State<pastBaskets> createState() => _pastBaskets();
}

class _pastBaskets extends State<pastBaskets> {

  @override
  void initState() {
    widget.baskets.forEach((element) {
      if(Auth().currentUser?.uid.toString()==element["user"].toString()){
        element["content"].forEach((element) => print(element["product"]["title"]));
      }
    });
    super.initState();
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
    );
  }
}
