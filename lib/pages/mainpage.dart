import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:html/dom.dart';
import 'package:techpack/pages/categories.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  String queryBuilder(String query, String store) {
    String url;
    if (store == "media markt") {
      url =
          "https://www.mediamarkt.com.tr/tr/search.html?query=$query&searchProfile=onlineshop&channel=mmtrtr&outlet=1771";
    } else if (store == "teknosa") {
      url = "https://www.teknosa.com/arama/?s=$query";
    } else if (store == "itopya") {
      url = "https://www.itopya.com/AramaSonuclari?text=$query";
    } else {
      url = "https://www.vatanbilgisayar.com/arama/$query/";
    }

    return url;
  }

  List<ProductModel> scraper(String store, Document document) {
    List<ProductModel> searchedProducts=[];

    if (store == "media markt") {
      var image = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[0]
          .children[1]
          .children[0]
          .children[0]
          .attributes["src"];

      var image1 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[1]
          .children[1]
          .children[0]
          .children[0]
          .attributes["src"];

      var image2 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[2]
          .children[1]
          .children[0]
          .children[0]
          .attributes["src"];

      var image3 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[3]
          .children[1]
          .children[0]
          .children[0]
          .attributes["src"];

      var title = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[0]
          .children[2]
          .children[0]
          .children[1]
          .children[0];

      var title1 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[1]
          .children[2]
          .children[0]
          .children[1]
          .children[0];

      var title2 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[2]
          .children[2]
          .children[0]
          .children[1]
          .children[0];

      var title3 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[3]
          .children[2]
          .children[0]
          .children[1]
          .children[0];

      var price = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[0]
          .children[2]
          .children[1]
          .children[0]
          .children[0]
          .attributes["data-price"];

      var price1 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[1]
          .children[2]
          .children[1]
          .children[0]
          .children[0]
          .attributes["data-price"];

      var price2 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[2]
          .children[2]
          .children[1]
          .children[0]
          .children[0]
          .attributes["data-price"];

      var price3 = document
          .getElementsByClassName("mm-products")[0]
          .children[0]
          .children[3]
          .children[2]
          .children[1]
          .children[0]
          .children[0]
          .attributes["data-price"];

      searchedProducts.addAll([
        ProductModel(
            title: title.text,
            category: "",
            price: int.parse(price!),
            vendor: "media markt",
            id: 0,
            image: image!),
        ProductModel(
            title: title1.text,
            category: "",
            price: int.parse(price1!),
            vendor: "media markt",
            id: 1,
            image: image1!),   
        ProductModel(
            title: title2.text,
            category: "",
            price: int.parse(price2!),
            vendor: "media markt",
            id: 2,
            image: image2!),
        ProductModel(
            title: title3.text,
            category: "",
            price: int.parse(price3!),
            vendor: "media markt",
            id: 3,
            image: image3!)
      ]);
    }
    else if (store == "vatan") {
        var image = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[0]
            .children[0]
            .children[0]
            .children[0]
            .children[0]
            .attributes["src"];

        var image1 = document
            .getElementsByClassName("wrapper-product-main")[0]
        .children[0]
        .children[1]
        .children[0]
        .children[0]
        .children[0]
        .children[0]
        .attributes["src"];
    var image2 = document
        .getElementsByClassName("wrapper-product-main")[0]
        .children[0]
        .children[2]
        .children[0]
        .children[0]
        .children[0]
        .children[0]
        .attributes["src"];
        var image3 = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[3]
            .children[0]
            .children[0]
            .children[0]
            .children[0]
            .attributes["src"];
        var title = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[0]
            .children[1]
            .children[1]
            .children[1]
            .children[0];
        var title1 = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[1]
            .children[1]
            .children[1]
            .children[1]
            .children[0];
        var title2 = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[2]
            .children[1]
            .children[1]
            .children[1]
            .children[0];
        var title3 = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[3]
            .children[1]
            .children[1]
            .children[1]
            .children[0];
        var price = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[0]
            .children[1]
            .children[2]
            .children[0];
        var price1 = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[1]
            .children[1]
            .children[2]
            .children[0];
        var price2 = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[2]
            .children[1]
            .children[2]
            .children[0];
        var price3 = document
            .getElementsByClassName("wrapper-product-main")[0]
            .children[0]
            .children[3]
            .children[1]
            .children[2]
            .children[0];
        searchedProducts.addAll([
          ProductModel(
              title: title.text,
              category: "",
              price: int.parse(price.text),
              vendor: "vatan",
              id: 0,
              image: image!),
          ProductModel(
              title: title1.text,
              category: "",
              price: int.parse(price1.text),
              vendor: "vatan",
              id: 1,
              image: image1!),
          ProductModel(
              title: title2.text,
              category: "",
              price: int.parse(price2.text),
              vendor: "vatan",
              id: 2,
              image: image2!),
          ProductModel(
              title: title3.text,
              category: "",
              price: int.parse(price3.text),
              vendor: "vatan",
              id: 3,
              image: image3!)
        ]);
      }
    else if (store == "teknosa") {
      var image = document
          .getElementsByClassName("products")[0]
          .children[1]
          .children[1]
          .children[2]
          .children[0]
          .children[0]
          .attributes["srcset"];

      var image1 = document
          .getElementsByClassName("products")[0]
          .children[2]
          .children[1]
          .children[2]
          .children[0]
          .children[0]
          .attributes["srcset"];
      var image2 = document
          .getElementsByClassName("products")[0]
          .children[3]
          .children[1]
          .children[2]
          .children[0]
          .children[0]
          .attributes["srcset"];
      var image3 = document
          .getElementsByClassName("products")[0]
          .children[4]
          .children[1]
          .children[2]
          .children[0]
          .children[0]
          .attributes["srcset"];
      var title = document
          .getElementsByClassName("products")[0]
          .children[1]
          .attributes["data-product-name"];
      var title1 = document
          .getElementsByClassName("products")[0]
          .children[2]
          .attributes["data-product-name"];
      var title2 = document
          .getElementsByClassName("products")[0]
          .children[3]
          .attributes["data-product-name"];
      var title3 = document
          .getElementsByClassName("products")[0]
          .children[4]
          .attributes["data-product-name"];
      var price = document
          .getElementsByClassName("products")[0]
          .children[1]
          .attributes["data-product-discounted-price"];
      var price1 = document
          .getElementsByClassName("products")[0]
          .children[2]
          .attributes["data-product-discounted-price"];
      var price2 = document
          .getElementsByClassName("products")[0]
          .children[3]
          .attributes["data-product-discounted-price"];
      var price3 = document
          .getElementsByClassName("products")[0]
          .children[4]
          .attributes["data-product-discounted-price"];
      searchedProducts.addAll([
        ProductModel(
            title: title.toString(),
            category: "",
            price: int.parse(price!),
            vendor: "teknosa",
            id: 0,
            image: image!),
        ProductModel(
            title: title1.toString(),
            category: "",
            price: int.parse(price1!),
            vendor: "teknosa",
            id: 1,
            image: image1!),
        ProductModel(
            title: title2.toString(),
            category: "",
            price: int.parse(price2!),
            vendor: "teknosa",
            id: 2,
            image: image2!),
        ProductModel(
            title: title3.toString(),
            category: "",
            price: int.parse(price3!),
            vendor: "teknosa",
            id: 3,
            image: image3!)
      ]);
    }
    else if (store == "itopya"){}
  }


  Future<List<String>> extractData(String query, String store) async {
    final response =
        await http.Client().get(Uri.parse(queryBuilder(query, store)));

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {} catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 320.0, top: 100),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Categories()),
                                );
                              },
                              icon: const Icon(Icons.shopping_basket,
                                  color: Colors.purple),
                              tooltip: 'Sepeti görüntüle'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              Image.asset('assets/logo.jpg'),
              Container(
                width: 300.0,
                child: TextField(
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Categories()),
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
                  textStyle: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.normal),
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
      ),
    );
  }
}
