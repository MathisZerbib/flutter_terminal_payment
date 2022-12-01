import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/cart_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, unitTag TEXT, image TEXT)');
  }

  Future<Cart> insert(Cart cart) async {
    final dbClient = await database;
    if (dbClient != null && cart.id != null) {
      await dbClient.insert(
        'cart',
        cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    // if (dbClient != null && cart.id != null) {
    //   print('dbClient');
    //   print(dbClient);
    //   print(cart.toMap());
    //   await dbClient.insert('cart', cart.toMap());
    // }
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    final dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> deleteCartItem(int id) async {
    final dbClient = await database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Cart cart) async {
    final dbClient = await database;
    return await dbClient!.update('cart', cart.quantityMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  Future<List<Cart>> getCartId(int id) async {
    final dbClient = await database;
    final List<Map<String, Object?>> queryIdResult =
        await dbClient!.query('cart', where: 'id = ?', whereArgs: [id]);
    return queryIdResult.map((e) => Cart.fromMap(e)).toList();
  }

  // Future<bool> alreadyInBase(int id) async {
  //   final dbClient = await database;
  //   final List<Map<String, Object?>> queryIdResult =
  //       await dbClient!.query('cart', where: 'id = ?', whereArgs: [id]);
  //   print('coucou');
  //   print(queryIdResult.map((e) => Cart.fromMap(e)).toList());
  //   if (queryIdResult.map((e) => Cart.fromMap(e)).toList().isEmpty) {
  //     return Future.value(true);
  //   } else {
  //     return Future.value(false);
  //   }
  // }
}
