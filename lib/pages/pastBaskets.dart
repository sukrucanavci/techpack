import 'package:flutter/material.dart';
import 'package:techpack/components/product_page.dart';


class pastBaskets extends StatefulWidget {
  const pastBaskets({super.key});

  @override
  State<pastBaskets> createState() => _pastBaskets();
}

class _pastBaskets extends State<pastBaskets> {
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
