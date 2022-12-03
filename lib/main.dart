import 'package:flutter/material.dart';
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

  Future<void> insertStore(Store store) async {
    final db = await database;

    await db.insert(
      'stores',
      store.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/splash.png"), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        50, 500, 10, 50)), //or const EdgeInsets.all(280.0),),
                CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
