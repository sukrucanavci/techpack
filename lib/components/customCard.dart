import 'package:flutter/material.dart';

class SepetEsyasi extends StatefulWidget {
  final String tutar;
  final String mesafe;
  final bool yuksekMi;

  const SepetEsyasi(
      {Key? key,
      required this.tutar,
      required this.mesafe,
      required this.yuksekMi})
      : super(key: key);

  @override
  State<SepetEsyasi> createState() => _nameState();
}

class _nameState extends State<SepetEsyasi> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Card(
          shape: selected
              ? new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.purple, width: 4),
                )
              : new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.black, width: 4),
                ),
          child: InkWell(
            onTap: () {
              setState(() {
                selected = !selected;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/lira.png",
                        width: 36,
                        height: 36,
                      ),
                      (widget.yuksekMi)
                          ? Image.asset("assets/images/up.png",
                              width: 24, height: 24, fit: BoxFit.fitWidth)
                          : Image.asset("assets/images/down.png",
                              width: 24, height: 24, fit: BoxFit.fitWidth),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Toplam Tutar'),
                            Container(
                              width: 11,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(":"),
                                  Text(widget.tutar),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Toplam Mesafe'),
                            Container(
                              width: 11,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(":"),
                                  Text(widget.mesafe),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
