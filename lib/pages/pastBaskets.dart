import 'package:flutter/material.dart';


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
        //element["content"].forEach((element) => print(element["product"]["title"]));
      print("${element['timestamp']} , ${element['user']}");
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
