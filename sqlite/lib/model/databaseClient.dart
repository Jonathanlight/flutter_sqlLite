import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'item.dart';

class DatabaseClient {

  Database _database;

  Future<Database> get database async {

    if (_database != null) {
      return _database;
    } else {
      _database = await create();
      return _database;
    }

  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String database_directory = join(directory.path, 'database.db');
    var bdd = await openDatabase(database_directory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE item(id INTEGER KEY, nom TEXT NOT NULL)
    ''');
  }

  Future<Item> ajoutItem(Item item) async {
    Database myDatabase = await database;
    item.id = await myDatabase.insert('item', item.toMap());
    return item;
  }

  Future<List<Item>> allItems() async {
    Database myDatabase = await database;
    List<Map<String, dynamic>> response = await myDatabase.rawQuery('SELECT * FROM item');
    List<Item> items =  [];

    response.forEach((map) {
      Item item = new Item();
      item.fromMap(map);
      items.add(item);
    });

    return items;
  }

}