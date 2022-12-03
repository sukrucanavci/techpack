import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:html/dom.dart' as dom;
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
          "https://www.mediamarkt.com.tr/tr/search.html?query=$query";
    } else if (store == "teknosa") {
      url = "https://www.teknosa.com/arama/?s=$query";
    } else if (store == "itopya") {
      url = "https://www.itopya.com/AramaSonuclari?text=$query";
    } else {
      url = "https://www.vatanbilgisayar.com/arama/$query/";
    }

    return url;
  }

  List<ProductModel> scraper(String store, dom.Document document, final http.Response response) {
    List<ProductModel> searchedProducts = [];
    dom.Document html = dom.Document.html(response.body);
    if (store == "itopya") {
      final titles = html
          .querySelectorAll('div.product-body > a')
          .map((e) => e.innerHtml.trim())
          .toList();
      print('Count:${titles.length}');
      for(final title in titles)
      {
        debugPrint(title);
      }
      final urls = html
          .querySelectorAll('div.product-header > a > img')
          .map((e) => e.attributes['data-src'])
          .toList();
      print('Count:${urls.length}');
      for(final title in urls)
      {
        debugPrint(title);
      }
      final prices = html
          .querySelectorAll('div.product-footer > div.price > strong')
          .map((e) => e.text)
          .toList();
      print('Count:${prices.length}');
      for(final title in prices)
      {
        debugPrint(title);
      }
    }
    else if (store == "vatan") {
      final titles = html
          .querySelectorAll('div.product-list__content > a > div.product-list__product-name > h3')
          .map((e) => e.innerHtml.trim())
          .toList();
      print('Count:${titles.length}');
      for(final title in titles)
      {
        debugPrint(title);
      }
      final urls = html
          .querySelectorAll('div.product-list__image-safe > a > div > img')
          .map((e) => e.attributes['data-src'])
          .toList();
      print('Count:${urls.length}');
      for(final title in urls)
      {
        debugPrint(title);
      }
      final prices = html
          .querySelectorAll('div.product-list__content > div.product-list__cost > span.product-list__price')
          .map((e) => e.text)
          .toList();
      print('Count:${prices.length}');
      for(final title in prices)
      {
        debugPrint(title);
      }
    }
    else if (store == "teknosa") {
      final titles = html
          .querySelectorAll('#product-item > a')
          .map((e) => e.attributes['title'])
          .toList();
      print('Count:${titles.length}');
      for(final title in titles)
      {
        debugPrint(title);
      }
      final urls = html
          .querySelectorAll('#product-item > div > div.prd-media > figure > img')
          .map((e) => e.attributes['data-srcset'])
          .toList();
      print('Count:${urls.length}');
      for(final title in urls)
      {
        debugPrint(title);
      }
      final prices = html
          .querySelectorAll('#product-item')
          .map((e) => e.attributes['data-product-price'])
          .toList();
      print('Count:${prices.length}');
      for(final title in prices)
      {
        debugPrint(title);
      }
    }

    return searchedProducts;
  }

  Future<List<ProductModel>?> extractData(String query, String store) async {
    final response =
        await http.Client().get(Uri.parse(queryBuilder(query, store)));

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        List<ProductModel> products = scraper(store, document,response);
        return products;
      } catch (e) {
        print(e);
      }
    } else {
      print('ERROR: ${response.statusCode}.');
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
                  onSubmitted: (value) async {
                    List<ProductModel> productList = [];
                    final teknosaResults = await extractData(value, "teknosa");
                    final itopyaResults = await extractData(value, "itopya");
                    final vatanResults = await extractData(value, "vatan");


                    productList.addAll(teknosaResults!);
                    productList.addAll(itopyaResults!);
                    productList.addAll(vatanResults!);

                //    productList.map((e) => print(e.title));

                    // ignore: use_build_context_synchronously
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
