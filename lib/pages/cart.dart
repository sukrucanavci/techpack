import 'package:flutter/material.dart';
import 'package:techpack/models/product_model.dart';
import 'package:techpack/pages/routes.dart';

class Cart extends StatefulWidget {
  final List<ProductModel> cart;
  final Map<String, String> logoMap;
  final void Function(ProductModel product) addToCart;
  final void Function(ProductModel product) removeFromCart;

  const Cart(
      {super.key,
        required this.cart,
        required this.logoMap,
        required this.addToCart,
        required this.removeFromCart});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<ProductModel, int> quantityMap = {};
  num total = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      widget.cart.forEach((productInCart) {
        if (!quantityMap.containsKey(productInCart)) {
          quantityMap[productInCart] = 1;
        } else {
          quantityMap[productInCart] = quantityMap[productInCart]! + 1;
        }
      });

      quantityMap.keys.forEach((product) {
        total += product.price * quantityMap[product]!;
      });
    });
  }

  void _addToQuantity(ProductModel product) {
    widget.addToCart(product);

    setState(() {
      total += product.price;
      quantityMap[product] = quantityMap[product]! + 1;
    });
  }

  void _removeFromQuantity(ProductModel product) {
    widget.removeFromCart(product);

    setState(() {
      total -= product.price;
      if (quantityMap[product] == 1) {
        quantityMap.remove(product);
      } else {
        quantityMap[product] = quantityMap[product]! - 1;
      }
    });
  }

  Widget _buildCard(MapEntry<ProductModel, int> entry) {
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
                        image: entry.key.category== "search"
                            ? NetworkImage(entry.key.image)
                            : AssetImage(entry.key.image) as ImageProvider,
                        fit: BoxFit.contain)),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: 150,
                child: Column(
                  children: [
                    Text(
                      entry.key.title,
                      style: const TextStyle(
                          color: Colors.deepPurple, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${entry.key.price} ₺",
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
            ]),
            Column(
              children: [
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.logoMap[entry.key.vendor]!),
                          fit: BoxFit.contain)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          _removeFromQuantity(entry.key);
                        },
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.purple)),
                    Text(
                      "${entry.value}",
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          _addToQuantity(entry.key);
                        },
                        icon: const Icon(Icons.add_circle_outline,
                            color: Colors.purple))
                  ],
                )
              ],
            )
          ],
        ));
  }

  @override
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
            "My Cart",
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
                    for (final entry in quantityMap.entries) _buildCard(entry),
                  ],
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: Container(
                    color: Colors.purple,
                    height: 2,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  quantityMap.keys.isEmpty
                      ? "You have no items"
                      : "Total: ${total.toStringAsFixed(3)} ₺",
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Routes(title: "tech pack"),
                      ));
                },
                backgroundColor: Colors.deepPurple,
                child: const Icon(Icons.map_outlined),
              ),
            )
          ],
        ));
  }
}
