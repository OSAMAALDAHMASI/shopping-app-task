// import 'dart:async';
// import 'dart:io';
// import 'package:path/path.dart';
//
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../../data/model/product_model.dart';
//
// class ProductRepository {
//   static const _databaseName = 'products_database.db';
//   static const _databaseVersion = 1;
//   static const _tableName = 'products';
//
//   late Database _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   Future<Database> _initDatabase() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);
//     return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
//   }
//
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE $_tableName (
//             id INTEGER PRIMARY KEY,
//             title TEXT,
//             price REAL,
//             description TEXT,
//             category TEXT,
//             image TEXT,
//             rate REAL,
//             count INTEGER
//           )
//           ''');
//   }
//
//   Future<List<Product>> getAllProducts() async {
//     Database db = await database;
//     List<Map<String, dynamic>> maps = await db.query(_tableName);
//     return List.generate(maps.length, (i) {
//       return Product(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         price: maps[i]['price'],
//         description: maps[i]['description'],
//         category: maps[i]['category'],
//         image: maps[i]['image'],
//         rating: Rating(rate: maps[i]['rate'], count: maps[i]['count']),
//       );
//     });
//   }
//
//   Future<void> insertProduct(Product product) async {
//     Database db = await database;
//     await db.insert(_tableName, product.toMap());
//   }
//
//   Future<void> updateProduct(Product product) async {
//     Database db = await database;
//     await db.update(_tableName, product.toMap(), where: 'id = ?', whereArgs: [product.id]);
//   }
//
//   Future<void> deleteProduct(int id) async {
//     Database db = await database;
//     await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
//   }
// }