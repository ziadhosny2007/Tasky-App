import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initial();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initial() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tasks.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  Future<void> _onCreate(Database mydb, int version) async {
    await mydb.execute('''

  CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      task TEXT NOT NULL,
      des TEXT,
      category TEXT NOT NULL,
      priority INTEGER NOT NULL,
      date TEXT,      -- 'YYYY-MM-DD'
      time TEXT,      -- 'HH:MM'
      is_done INTEGER NOT NULL DEFAULT 0
    )

''');
    print("Create local database==================================");
    print(mydb);
  }

  Future<void> _onUpgrade(Database mydb, int oldVersion, int newVersion) async {
    await mydb.execute('''
''');
    print("Upgrade local database==================================");
  }

  Future<List<Map>> selectData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
}
