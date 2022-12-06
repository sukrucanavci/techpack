import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:techpack/pages/mainpage.dart';
import 'package:sqflite/sqflite.dart';
import 'models/stores_model.dart';
import 'package:path/path.dart' as Path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    Path.join(await getDatabasesPath(), 'techpack_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE stores(id INTEGER PRIMARY KEY, name TEXT, latitude TEXT, longitude TEXT, address TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertStores(List<Store> stores) async {
    final db = await database;

    for (var store in stores) {
      await db.insert(
        'stores',
        store.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Store>> stores() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('stores');

    return List.generate(maps.length, (i) {
      return Store(
        id: maps[i]['id'],
        name: maps[i]['name'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        address: maps[i]['address'],
      );
    });
  }

  Future<void> deleteStore(int id) async {
    final db = await database;

    await db.delete(
      'stores',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  var vatan0 = const Store(
      id: 0,
      name: "İstanbul (212 Outlet AVM)",
      latitude: "41.047729",
      longitude: "28.810619",
      address:
          "Mahmutbey Mahallesi, 212 Outlet AVM, Taşocağı Yolu BAĞCILAR/İSTANBUL/Türkiye");

  var vatan1 = const Store(
      id: 1,
      name: "İstanbul (Acıbadem)",
      latitude: "40.99862984",
      longitude: "29.03260589",
      address:
          "Sarayardı Cd. Fatih Sk. No:6 Nautilus AVM Karşısı KADIKÖY/İSTANBUL/Türkiye");

  var vatan2 = const Store(
      id: 2,
      name: "İstanbul (Alibeyköy)",
      latitude: "41.076171",
      longitude: "28.943723",
      address:
          "Vardar Cd No:28 Haliç Rezidans No: A27/C41 EYÜP/İSTANBUL/Türkiye");

  var vatan3 = const Store(
      id: 3,
      name: "İstanbul (Altunizade)",
      latitude: "41.022801",
      longitude: "29.045464",
      address:
          "Altunizade Mah. Kısıklı Cad.No:47/Z1Üsküdar ÜSKÜDAR/İSTANBUL/Türkiye");

  var vatan4 = const Store(
      id: 4,
      name: "İstanbul (Astoria)",
      latitude: "41.068121",
      longitude: "29.005909",
      address:
          "Astoria AVM Büyükdere cad No:127/B1-07/08/09 ŞİŞLİ/İSTANBUL/Türkiye");

  var vatan5 = const Store(
      id: 5,
      name: "İstanbul (Avcılar)",
      latitude: "40.991403",
      longitude: "28.715112",
      address: "E-5 Yan Yol No:42 Pelican Mall AVM AVCILAR/İSTANBUL/Türkiye");

  var vatan6 = const Store(
      id: 6,
      name: "İstanbul (Bahçelievler)",
      latitude: "40.995833",
      longitude: "28.864783",
      address:
          "Mehmetçik Sokak No:1 Kadir Has Center AVM BAHÇELİEVLER/İSTANBUL/Türkiye");

  var vatan7 = const Store(
      id: 7,
      name: "İstanbul (Bahçeşehir)",
      latitude: "41.056593",
      longitude: "28.669013",
      address:
          "1655 Sokak No:3 /1-2Akbatı AVM Ana Giriş Kapısı Esenyurt BAHÇEŞEHİR/İSTANBUL/Türkiye");

  var vatan8 = const Store(
      id: 8,
      name: "İstanbul (Başakşehir Arterium)",
      latitude: "41.102183",
      longitude: "28.78795",
      address:
          "Arterium Sitesi Toros Caddesi No:11/12 BAŞAKŞEHİR/İSTANBUL/Türkiye");

  var vatan9 = const Store(
      id: 9,
      name: "İstanbul (Beylikdüzü)",
      latitude: "41.015349",
      longitude: "28.642586",
      address: "E5 Karayolu Üzeri 1995 Sokak No:2 ESENYURT/İSTANBUL/Türkiye");

  var vatan10 = const Store(
      id: 10,
      name: "İstanbul (Bostancı)",
      latitude: "40.967191",
      longitude: "29.104309",
      address:
          "İçerenköy Mah. Yeşil Vadi Sok.No:3/1 34752 ATAŞEHIR/İSTANBUL/Türkiye");

  var vatan11 = const Store(
      id: 11,
      name: "İstanbul (Buyaka AVM)",
      latitude: "41.026333",
      longitude: "29.12741",
      address:
          "Balkan Caddesi Buyaka AVM Sit.D- Blok Apt. No:56 D/21 ÜMRANİYE/İSTANBUL/Türkiye");

  var vatan12 = const Store(
      id: 12,
      name: "İstanbul (Canpark)",
      latitude: "41.025068",
      longitude: "29.106349",
      address: "Alemdağ Cad. no:169/12. kat ÜMRANİYE/İSTANBUL/Türkiye");

  var vatan13 = const Store(
      id: 13,
      name: "İstanbul (Dudullu)",
      latitude: "41.016794",
      longitude: "29.159713",
      address:
          "Alemdağ Cad. No:457Yukarıdudullu Ümraniye DUDULLU/İSTANBUL/Türkiye");

  var vatan14 = const Store(
      id: 14,
      name: "İstanbul (Elmadağ)",
      latitude: "41.045865",
      longitude: "28.986334",
      address:
          "Cumhuriyet Caddesi Ferah Apt. No:139/5(Radyo Evi karşısı) ŞİŞLİ/İSTANBUL/Türkiye");

  var vatan15 = const Store(
      id: 15,
      name: "İstanbul (Esenyurt)",
      latitude: "41.030426",
      longitude: "28.670802",
      address:
          "Pınar Mh. 19 Mayıs BulvarıNo:38 Esila Kent SitesiZeminkat Esenyurt ESENYURT/İSTANBUL/Türkiye");

  var vatan16 = const Store(
      id: 16,
      name: "İstanbul (Forum İstanbul)",
      latitude: "41.045569",
      longitude: "28.897219",
      address:
          "Forum İstanbul B1 Mağaza No:45 Paşa Caddesi BAYRAMPAŞA/İSTANBUL/Türkiye");

  var vatan17 = const Store(
      id: 17,
      name: "İstanbul (Gaziosmanpaşa)",
      latitude: "41.0567203",
      longitude: "28.915779",
      address:
          "Muratpaşa Mah. Eski edirne asfaltı(cadde) no:1/15 BAYRAMPAŞA/İSTANBUL/Türkiye");

  var vatan18 = const Store(
      id: 18,
      name: "İstanbul (Mall Of İstanbul AVM)",
      latitude: "41.063056",
      longitude: "28.807222",
      address: "Süleyman Demirel Caddesi No:7 İKİTELLİ/İSTANBUL/Türkiye");

  var vatan19 = const Store(
      id: 19,
      name: "İstanbul (Haramidere)",
      latitude: "41.006512",
      longitude: "28.667498",
      address:
          "E5 üzeri M.Akif Ersoy Cd. Gökdemir Plaza 1. kat ESENYURT/İSTANBUL/Türkiye");

//MediaMarkt

  var mediamarkt0 = const Store(
      id: 0,
      name: "İstanbul | 212 Power Outlet AVM",
      latitude: "41.0477142",
      longitude: "28.8095368",
      address: "Mahmutbey Mah. Taşocağı Cad. No: 534550 İstanbul");

  var mediamarkt1 = const Store(
      id: 1,
      name: "İstanbul | Axis AVM",
      latitude: "41.0865343",
      longitude: "28.9815192",
      address: "Merkez Mahallesi No:48 34400 Kağıthane - İstanbul");

  var mediamarkt2 = const Store(
      id: 2,
      name: "İstanbul | Bahçeşehir Migros AVM",
      latitude: "41.0619536",
      longitude: "28.6875488",
      address: "Bahcesehir 2.Kısım Mah. No:1A 34488 İstanbul");

  var mediamarkt3 = const Store(
      id: 3,
      name: "İstanbul | Beylikdüzü",
      latitude: "41.007593",
      longitude: "28.6682067",
      address:
          "Güzelyurt Mah. Kurtuluş Cad. Yakuplu 34524 Beylikdüzü / İstanbul");

  var mediamarkt4 = const Store(
      id: 4,
      name: "İstanbul | Brandium AVM",
      latitude: "40.9826266",
      longitude: "29.1305076",
      address: "Küçükbakkalköy Mah. No:23-25 34750 Ataşehir - İstanbul");

  var mediamarkt5 = const Store(
      id: 5,
      name: "İstanbul | Capacity AVM",
      latitude: "40.9775876",
      longitude: "28.8700708",
      address:
          "Ataköy 1.Kısım Mah. Fişekhane Cad. No:7 34158 Bakırköy - İstanbul");

  var mediamarkt6 = const Store(
      id: 6,
      name: "İstanbul | Emaar AVM",
      latitude: "41.0023337",
      longitude: "29.0652993",
      address:
          "Emaar Square Mall Unalan Mahallesi No:78 34700 Istanbul / Uskudar");

  var mediamarkt7 = const Store(
      id: 7,
      name: "İstanbul | Forum İstanbul AVM",
      latitude: "41.0446596",
      longitude: "28.8930641",
      address: "Kocatepe Mah. Paşa Cad. 34045 Bayrampaşa / İstanbul");

  var mediamarkt8 = const Store(
      id: 8,
      name: "İstanbul | Hilltown AVM",
      latitude: "40.9527112",
      longitude: "29.1220676",
      address:
          "Aydınevler Mah. Siteler Yolu Sok. No:1/29 34854 Maltepe - İstanbul");

  var mediamarkt9 = const Store(
      id: 9,
      name: "İstanbul | İstMarina",
      latitude: "40.8886407",
      longitude: "29.1856268",
      address: "Kordonboyu Mah. Ankara Caddesi 52-53 34860 Kartal / İstanbul");

  var mediamarkt10 = const Store(
      id: 10,
      name: "İstanbul | Levent",
      latitude: "41.0929094",
      longitude: "29.0018851",
      address:
          "Yeşilce Mah. Eski Büyükdere Cad. No:65 34415 Kağıthane - İstanbul");

  var mediamarkt11 = const Store(
      id: 11,
      name: "İstanbul | Mall of İstanbul AVM",
      latitude: "41.0553328",
      longitude: "28.7904789",
      address: "Ziya Gökalp Mah. No:7E1 34490 İkitelli - İstanbul");

  var mediamarkt12 = const Store(
      id: 12,
      name: "İstanbul | Marmara Forum AVM",
      latitude: "40.9979595",
      longitude: "28.8834033",
      address: "Ekrem Kurt Bulvarı E-5 Yolu Üzeri 34145 İstanbul");

  var mediamarkt13 = const Store(
      id: 13,
      name: "İstanbul | Marmara Park AVM",
      latitude: "41.009499",
      longitude: "28.6970563",
      address: "Güzelyurt Mah. 1. Sok. No:31 34524 Beylikdüzü / İstanbul");

  var mediamarkt14 = const Store(
      id: 14,
      name: "İstanbul | Metrogarden AVM",
      latitude: "41.0155583",
      longitude: "29.1763046",
      address:
          "Necip Fazil Mahallesi Alemdag Caddesi No:940 34773 Ümraniye - İstanbul");

  var mediamarkt15 = const Store(
      id: 15,
      name: "İstanbul | Metropol İstanbul AVM",
      latitude: "41.0280941",
      longitude: "29.0546999",
      address: "Atatürk Mh. Ertuğrul Gazi Sk. 34758 Ataşehir - İstanbul");

  var mediamarkt16 = const Store(
      id: 16,
      name: "İstanbul | Meydan AVM",
      latitude: "41.0232314",
      longitude: "29.1245632",
      address:
          "Fatih Sultan Mehmet Mah. Balkan Sok. No:64 34771 Ümraniye - İstanbul");

  var mediamarkt17 = const Store(
      id: 17,
      name: "İstanbul | Optimum AVM",
      latitude: "40.9888408",
      longitude: "29.0836663",
      address: "İstiklal Sokak No.2/B Yenisahra 34746 Ataşehir - İstanbul");

  var mediamarkt18 = const Store(
      id: 18,
      name: "İstanbul | Özdilek Park AVM",
      latitude: "41.0766493",
      longitude: "29.0067382",
      address: "Esentepe Mah. Dede Korkut Sk. No:1534394 Şişli - İstanbul");

  var mediamarkt19 = const Store(
      id: 19,
      name: "İstanbul | Torium AVM",
      latitude: "41.003801",
      longitude: "28.6846083",
      address: "Turgut Ozal Mah. 68.Sokak No:50 34513 Esenyurt");

  //itopya

  var itopya0 = const Store(
      id: 0,
      name: "ITOPYA Acıbadem",
      latitude: "41.000714",
      longitude: "29.049077",
      address:
          "Hasanpaşa Mah. Lavanta Sok. Etap İş Merkezi D Blok No: 22/B1 Kadıköy/İstanbul");

  var itopya1 = const Store(
      id: 1,
      name: "ITOPYA Airport AVM Ataköy",
      latitude: "39.9102862",
      longitude: "32.7970818",
      address:
          "Ataköy Airport Alışveriş Merkezi 2. Kat 34158 Bakırköy/İstanbul");

  var itopya2 = const Store(
      id: 2,
      name: "ITOPYA Beylikdüzü",
      latitude: "41.0118041",
      longitude: "28.6538669",
      address: "Belediye Cad. Ginza Lavinya No: 30/A5 Beylikdüzü/İstanbul");

  var itopya3 = const Store(
      id: 3,
      name: "ITOPYA Kartal Outlet",
      latitude: "40.909179",
      longitude: "29.197424",
      address:
          "Mahallesi, Kartal D100 Güney Yan Yol, No:15, D:6 Kartal/İstanbul");

  var itopya4 = const Store(
      id: 4,
      name: "ITOPYA Söğütözü",
      latitude: "39.910057",
      longitude: "32.797176",
      address: "Söğütözü Mahallesi, 2176. Sokak No:7/B Çankaya/Ankara");

  //teknosa

  var teknosa0 = const Store(
      id: 0,
      name: "İstanbul Tuzla Viaport Mari̇n",
      latitude: "40.81755",
      longitude: "29.31535",
      address:
          "Cami Mah. Şehitler Cad. Balıkçılar Sok. No:20 Viaport Marin Avm. Mağaza No: Zk-026 İSTASYON MAH TUZLA İstanbul TR");

  var teknosa1 = const Store(
      id: 1,
      name: "İstanbul Kurtköy Viaport",
      latitude: "40.93699",
      longitude: "29.3257",
      address:
          "Yenişehir Mah. Dede Paşa Cad. Viaport Avm No:2 Mağ. No: 098-099 KURTKÖY MAH PENDİK İstanbul TR");

  var teknosa2 = const Store(
      id: 2,
      name: "İstanbul Pendi̇k Neomari̇n",
      latitude: "40.86385",
      longitude: "29.27386",
      address:
          "Kaynarca Mah. Tershane Kavşak Cad. Neomarin Avm C-01 KAYNARCA MAH PENDİK İstanbul TR");

  var teknosa3 = const Store(
      id: 3,
      name: "İstanbul Kartal İstmari̇na",
      latitude: "40.88484",
      longitude: "29.20657",
      address:
          "Çavuşoğlu Mah.Ankara Cad. No:147-6 Mğz. No:151-152 ÇAVUŞOĞLU MAH KARTAL İstanbul TR");

  var teknosa4 = const Store(
      id: 4,
      name: "İstanbul Maltepe Carrefoursa Exxtra",
      latitude: "40.91963",
      longitude: "29.16372",
      address:
          "Cevizli Mah. Tugay Yolu Cad. No:73 Maltepe Park Avm CEVİZLİ MAH MALTEPE İstanbul TR");

  var teknosa5 = const Store(
      id: 5,
      name: "İstanbul Sur Yapi Metrogarden",
      latitude: "41.01558",
      longitude: "29.17874",
      address:
          "Necip Fazıl Mah. Mabeyn Cad. No:3 Metrogarden Avm Mğz No:163-164 NECİP FAZIL MAH ÜMRANİYE İstanbul TR");

  var teknosa6 = const Store(
      id: 6,
      name: "İstanbul Küçükyali Hi̇lltown",
      latitude: "40.9993216",
      longitude: "29.0226176",
      address:
          "Aydınevler Mah.Siteleryolu Sok No:1 Hilltown Avm B2-19 AYDINEVLER MAH MALTEPE İstanbul TR");

  var teknosa7 = const Store(
      id: 7,
      name: "İstanbul Ataşehi̇r Brandium Extra",
      latitude: "40.9822",
      longitude: "29.13173",
      address:
          "Küçükbakkalköy Mah. Dudullu Yolu Cad. Erenköy Gümrük Karşısı Brandıum Avm N:18-21-22 KÜÇÜKBAKKALKÖY MAH ATAŞEHİR İstanbul TR");

  var teknosa8 = const Store(
      id: 8,
      name: "İstanbul Kozyataği Ci̇tys Extra",
      latitude: "40.9777",
      longitude: "29.09864",
      address:
          "Kozyatağı Carrefour AVM İçerenköy, İçerenköy Carrefour No:1, 34752 Ataşehir-İstanbul İÇERENKÖY MAH ATAŞEHİR İstanbul TR");

  var teknosa9 = const Store(
      id: 9,
      name: "İstanbul Ümrani̇ye Buyaka",
      latitude: "41.03406",
      longitude: "29.11281",
      address:
          "Fatih Sultan Mehmet Mah. Balkan Cad. No:56 B-160 Buyaka AVM ,Kat : 1 ,Bağımsız Bölüm No: 123-124-125 FATİH SULTAN MEHMET MAH ÜMRANİYE İstanbul TR");

  var teknosa10 = const Store(
      id: 10,
      name: "İstanbul Ümrani̇ye Canpark",
      latitude: "41.025",
      longitude: "29.10626",
      address:
          "İnkilap Mah. Alemdağ Cd. No:169 Canpark Avm Mağaza No:B134-135 İNKILAP MAH ÜMRANİYE İstanbul TR");

  var teknosa11 = const Store(
      id: 11,
      name: "Carrefoursa Istanbul Selami̇çeşme Gurme",
      latitude: "40.97527",
      longitude: "29.05222",
      address:
          "Zühtüpaşa Mahallesi, Bağdat Caddesi, NO:194 Kadıköy / İSTANBUL");

  var teknosa12 = const Store(
      id: 12,
      name: "İstanbul Acibadem Akasya",
      latitude: "41.0017",
      longitude: "29.05506",
      address:
          "Acıbadem Mah. Ankara Devlet Yolu Haydarpaşa Yönü 4. Km. Çeçen Sok., Akasya Acıbadem,No:560 ACIBADEM MAH ÜSKÜDAR İstanbul TR");

  var teknosa13 = const Store(
      id: 13,
      name: "İstanbul Kadiköy Tepe Nautilus Exxtra",
      latitude: "40.9996",
      longitude: "29.03172",
      address:
          "Acıbadem Mah. Fatih Cad. Tepe Nautilus Avm No: 1 D: 163 ACIBADEM MAH ÜSKÜDAR İstanbul TR");

  var teknosa14 = const Store(
      id: 14,
      name: "İstanbul Altuni̇zade Capitol",
      latitude: "41.02086",
      longitude: "29.03943",
      address:
          "Mahiriz Cad. Capitol Avm No:71 ALTUNİZADE MAH ÜSKÜDAR İstanbul TR");

  var teknosa15 = const Store(
      id: 15,
      name: "Carrefoursa İstanbul İsti̇nye Hi̇per",
      latitude: "41.11773",
      longitude: "29.04937",
      address: "İstinye Mah. Çayır Cad. No:1 SARIYER İstanbul TR");

  var teknosa16 = const Store(
      id: 16,
      name: "İstanbul Eti̇ler Akmerkez",
      latitude: "41.07690152089097",
      longitude: "29.026803907270917",
      address:
          "İstanbul Nispetiye Caddesi Akmerkez Avm 418-419 nolu mağaza ETİLER MAH BEŞİKTAŞ İstanbul TR");

  var teknosa17 = const Store(
      id: 17,
      name: "İstanbul Beşi̇ktaş Çarşi Yeni̇",
      latitude: "41.04295",
      longitude: "29.00424",
      address:
          "Sinanpaşa Mah. Ortabahçe Cad No:16 SİNANPAŞA MAH BEŞİKTAŞ İstanbul TR");

  var teknosa18 = const Store(
      id: 18,
      name: "İstanbul İsti̇nye Park Exxtra",
      latitude: "41.10996",
      longitude: "29.03223",
      address:
          "Pınar Mahallesi İstinye Bayırı Cad. İstinye Park Alışveriş Merkezi No:73 Mgz No: L206 - L208, 34460 İSTİNYE MAH SARIYER İstanbul TR");

  var teknosa19 = const Store(
      id: 19,
      name: "İstanbul Levent Metrocity Extra Yeni̇",
      latitude: "41.07615",
      longitude: "29.01295",
      address:
          "Büyükdere Cad. N0 171 Metrocity Avm Kat-1 LEVENT MAH BEŞİKTAŞ İstanbul TR");

  await insertStores([
    vatan0,
    vatan1,
    vatan2,
    vatan3,
    vatan4,
    vatan5,
    vatan6,
    vatan7,
    vatan8,
    vatan9,
    vatan10,
    vatan11,
    vatan12,
    vatan13,
    vatan14,
    vatan15,
    vatan16,
    vatan17,
    vatan18,
    vatan19,
    mediamarkt0,
    mediamarkt1,
    mediamarkt2,
    mediamarkt3,
    mediamarkt4,
    mediamarkt5,
    mediamarkt6,
    mediamarkt7,
    mediamarkt8,
    mediamarkt9,
    mediamarkt10,
    mediamarkt11,
    mediamarkt12,
    mediamarkt13,
    mediamarkt14,
    mediamarkt15,
    mediamarkt16,
    mediamarkt17,
    mediamarkt18,
    mediamarkt19,
    itopya0,
    itopya1,
    itopya2,
    itopya3,
    itopya4,
    teknosa0,
    teknosa1,
    teknosa2,
    teknosa3,
    teknosa4,
    teknosa5,
    teknosa6,
    teknosa7,
    teknosa8,
    teknosa9,
    teknosa10,
    teknosa11,
    teknosa12,
    teknosa13,
    teknosa14,
    teknosa15,
    teknosa16,
    teknosa17,
    teknosa18,
    teknosa19
  ]);

  print(await stores());

  runApp(MaterialApp(
      title: "tech pack",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Mainpage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: <Widget>[
              Expanded(
                  flex:1,
                  child: Image.asset('assets/images/104314.png')
              ),
              Expanded(
                  flex:1,
                  child: Image.asset('assets/images/Vatan_Computer.jpg')
              ),
              Expanded(
                  flex:1,
                  child: Image.asset('assets/images/TEKnosa.png')
              ),
              Expanded(
                  flex:2,
                  child: Image.asset('assets/logo.jpg')
              ),
              Expanded(
                flex:1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                  CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
