import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techpack/components/filter_sort.dart';
import 'package:techpack/components/navbar.dart';
import 'package:techpack/components/products.dart';
import 'package:techpack/models/product_model.dart';
import 'package:techpack/product_info.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Tech Pack",
        theme: ThemeData(
            primarySwatch: Colors.purple,
            scaffoldBackgroundColor: Colors.white),
        home: const Categories());
  }
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() =>  _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<ProductModel>? _products;
  List<ProductModel> _cart = [];
  final Map<String, String> _logoMap = {
    "itopya": "assets/images/104314.png",
    "vatan bilgisayar": "assets/images/Vatan_Computer.jpg",
    "teknosa": "assets/images/TEKnosa.png",
    "media markt": "assets/images/Media_Markt_red_textmark.png"
  };

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _getProducts() async {
    List<dynamic> data = json
        .decode(await rootBundle.loadString("assets/data/mock_products.json"));
    List<ProductModel> prods =
        data.map((data) => ProductModel.fromJson(data)).toList();
    setState(() {
      _products = prods;
    });
  }

  void _addToCart(ProductModel product) {
    setState(() {
      _cart = [..._cart, product];
    });
  }

  void _removeFromCart(ProductModel product) {
    final int index =
        _cart.indexWhere((productInCart) => productInCart.id == product.id);

    setState(() {
      _cart.removeAt(index);
      _cart = [..._cart];
    });
  }

  @override
  Widget build(BuildContext context) {
    return _products == null
        ? const Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ))
        : ProductInfo(
            cart: _cart,
            products: _products!,
            removeFromCart: _removeFromCart,
            addToCart: _addToCart,
            logoMap: _logoMap,
            child: Scaffold(
              appBar: const Navbar(),
              body: Center(
                child: Column(
                  children: const [Filter(), Products()],
                ),
              ),
            ),
          );
  }
}
