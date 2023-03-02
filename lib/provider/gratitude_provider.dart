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
  bool _filterOn = false;
  bool _testMode = false;

  @override
  Gratitudes({testMode = false}) {
    _testMode = testMode;
    loadItems();
  }

  List<Gratitude> get items {
    return UnmodifiableListView<Gratitude>(
        _filterOn ? _items.where((element) => element.favorite == 1) : _items);
  }

  void loadItems() async {
    await _dbOpen();
    await _setupTemplate();
    await _dbLoad();
    notifyListeners();
  }

  void addItem(Gratitude g) async {
    int id;
    _items.insert(0, g);
    id = await _dbInsert(g);
    g.id = id;
    _items.sort((a, b) => -a.cdate!.compareTo(b.cdate!));
    notifyListeners();
  }

  void editItem(int id, String content) {
    final Gratitude g = _items.firstWhere((e) => e.id == id);
    g.content = content;
    _dbUpdate(id);
    notifyListeners();
  }

  void toggleFavorite(int id) {
    final Gratitude g = _items.firstWhere((e) => e.id == id);
    g.favorite = (1 - g.favorite!);
    _dbUpdate(g.id!);
    notifyListeners();
  }

  void setFilterOn(bool filterOn) {
    _filterOn = filterOn;
    notifyListeners();
  }

  void removeItem(int id) {
    _dbDelete(id);
    _items.removeWhere((element) => element.id == id);
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
    String path = join(await getDatabasesPath(), _getDatabaseName());
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

  Future<int> _dbInsert(Gratitude gratitude) async {
    final int id = await db!.insert(
      TABLE_NAME,
      gratitude.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<void> _dbUpdate(int id) async {
    final Gratitude g = _items.firstWhere((e) => e.id == id);
    await db!.update(
      TABLE_NAME,
      g.toMap(),
      where: "id = ?",
      whereArgs: [id],
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
  // The template entry for today does not have an id yet.
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

  String _getDatabaseName() {
    return DB_NAME;
  }
}
