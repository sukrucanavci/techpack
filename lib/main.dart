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
