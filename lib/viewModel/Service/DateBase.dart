import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import '../../model/items_model.dart';
final dataBase = ChangeNotifierProvider((ref) {
  return DB();
});
class DB extends ChangeNotifier{


  DB();
  static final DB instance = DB._init();

  static Database? _database;

  DB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('itemsDb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);

  }
  Future _onCreate(Database db, int version) async {
    await db.execute(
        "create table items(id integer primary key autoincrement, title text)");

  }

  Future<int> insertItem(ItemsModel itemsModel) async {
    final db = await instance.database;
    notifyListeners();
    return db.insert("items", itemsModel.toMap());
  }
  Future<void> deleteItem(id) async {
    final db = await instance.database;
    await db.delete('items', where: "id = ?", whereArgs: [id]);
    notifyListeners();

  }
  Future<int> updateItem( id,ItemsModel itemsModel) async {
    final db = await instance.database;
    notifyListeners();
    return await db.update('items',itemsModel.toMap(), where: "id = ?", whereArgs: [id]);
  }
  Future<List> getItems() async {
    final db = await instance.database;
    notifyListeners();
    return db.query("items");
  }
  Future<List<ItemsModel>> checkItemsExist(
      ItemsModel itemsModel) async {
    final db = await instance.database;
    final result = await db.query('items',
        where: 'id = ?', whereArgs: [itemsModel.id]);
    notifyListeners();
    return result.map((json) => ItemsModel.fromMap(json)).toList();
  }

}