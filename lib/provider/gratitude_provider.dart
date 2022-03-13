import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/gratitude_model.dart';

const DB_NAME = "gratitude.db";
const TABLE_NAME = "gratitude";

// The key represents the version of the database.
// Remember to update _dbLoad() when schema changes.
// TODO only support one sql statement in each version?
Map<int, String> migrationScripts = {
  1: '''
  CREATE TABLE gratitude (
    id INTEGER PRIMARY KEY, 
    cdate DATE, 
    content TEXT, 
    icon INTEGER
    )
  ''',
  2: '''
  ALTER TABLE gratitude ADD type INTEGER;
  ''',
  3: '''
  ALTER TABLE gratitude ADD favorite INTEGER;
  ''',
  4: '''
  ALTER TABLE gratitude ADD hashtag TEXT;
  ''',
};

class Gratitudes with ChangeNotifier {
  List<Gratitude> _items = [];
  Database? db;

  @override
  Gratitudes() {
    loadItems();
  }

  List<Gratitude> get items {
    return UnmodifiableListView<Gratitude>(_items);
  }

  void loadItems() async {
    await _dbOpen();
    await _setupTemplate();
    await _dbLoad();
    notifyListeners();
  }

  void addItem(Gratitude gratitude) {
    //TODO: make it an option to add to top or bottom of list
    //// _items.add(task);
    _items.insert(0, gratitude);
    _dbInsert(gratitude);
    _items.sort((a, b) => -a.cdate!.compareTo(b.cdate!));
    notifyListeners();
  }

  void editItem(int index, String content) {
    _items[index].content = content;
    _dbUpdate(_items[index]);
    // _items.insert(0, _items.removeAt(index));
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _items[index].favorite = 1 - _items[index].favorite!;
    _dbUpdate(_items[index]);
    notifyListeners();
  }

  void removeItem(int index) {
    _dbDelete(_items[index].id!);
    _items.removeAt(index);
    notifyListeners();
  }

  String export() {
    var content = "";
    var buffer = "";

    for (var item in items) {
      buffer = DateFormat("EEEE, MMMM d, yyyy").format(item.cdate!) + '\n';
      buffer += item.content ?? "";
      content += buffer + '\n\n';
    }

    return content;
  }

  // --------------------------
  // Internal Database Routines
  // --------------------------

  Future<void> _dbOpen() async {
    int count = migrationScripts.length;
    String path = join(await getDatabasesPath(), DB_NAME);
    //print('db location: $path');
    db = await openDatabase(
      path,
      version: count,
      // if the database does not exist, onCreate executes all sql statements
      // in the "migrationScripts" map one by one in ascending order.
      onCreate: (Database db, int version) async {
        print("sqflite onCreate version $version");
        for (int i = 1; i <= count; i++) {
          await db.execute(migrationScripts[i]!);
        }
      },
      // if the database exists but the version of the database is different
      // from the version defined in parameter, onUpgrade will execute all sql
      // statements greater than the old version.
      onUpgrade: (db, oldVersion, newVersion) async {
        print("sqflite onUpgrade version "
            "$oldVersion -> $newVersion");
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          await db.execute(migrationScripts[i]!);
        }
      },
    );
  }

  Future<void> _dbLoad() async {
    final List<Map<String, dynamic>> result =
        await db!.query(TABLE_NAME, orderBy: "cdate desc");
    // Convert the List<Map<String, dynamic> into a List<Gratitude>.
    _items = List.generate(result.length, (i) {
      return Gratitude(
        id: result[i]['id'],
        cdate: DateTime.parse(result[i]['cdate']),
        content: result[i]['content'] ?? "",
        icon: result[i]['icon'],
        type: result[i]['type'],
        favorite: result[i]['favorite'],
        hashtag: result[i]['hashtag'] ?? "",
      );
    });
  }

  Future<void> _dbInsert(Gratitude gratitude) async {
    await db!.insert(
      TABLE_NAME,
      gratitude.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _dbUpdate(Gratitude gratitude) async {
    await db!.update(
      TABLE_NAME,
      gratitude.toMap(),
      where: "id = ?",
      whereArgs: [gratitude.id],
    );
  }

  Future<void> _dbDelete(int id) async {
    await db!.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Create an empty entry for "today" if it does not exist, and
  // remove all empty entries other than for today.
  Future<void> _setupTemplate() async {
    late final Gratitude g;
    final DateTime today;
    final String sql;
    late var count;

    // remove all empty entries
    count = await db!.delete(TABLE_NAME, where: "content = ?", whereArgs: [""]);

    // check if today entry exists
    today = DateTime.now();
    final datestr = DateFormat("yyyy-MM-dd").format(today);
    sql = "SELECT COUNT(*) FROM $TABLE_NAME where date(cdate)='$datestr'";

    count = Sqflite.firstIntValue(await db!.rawQuery(sql));

    // create today entry if not exists
    if (0 == count) {
      g = Gratitude(cdate: today, content: "");
      this._dbInsert(g);
    }
  }
}
