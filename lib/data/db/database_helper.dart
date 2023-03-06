import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblUsers = 'users';
  static const String _tblAgendas = 'agendas';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/agendaapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblUsers (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          firstname TEXT,
          lastname TEXT,
          email TEXT,
          birthdate TEXT,
          gender TEXT,
          password TEXT,
          photo TEXT
        )
        ''');

        await db.execute('''CREATE TABLE $_tblAgendas (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          title TEXT,
          description TEXT,
          datetime TEXT,
          attachment TEXT,
          reminder TEXT
        )
        ''');

        await db.execute('''
          INSERT INTO $_tblUsers (firstname, lastname, email, birthdate, gender, password, photo)
          VALUES(?,?,?,?,?,?,?)
        ''', [
          "Candidate",
          "Deptech",
          "candidate@deptechdigital.com",
          "1999-11-11",
          "male",
          "testInterview123!",
          "image_profile.png"
        ]);
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  // Future<void> insertUser(RestaurantElement restaurantElement) async {
  //   final db = await database;
  //   await db!.insert(_tblUsers, restaurantElement.toJson());
  // }

  // Future<List<RestaurantElement>> getFavourites() async {
  //   final db = await database;
  //   List<Map<String, dynamic>> results = await db!.query(_tblUsers);

  //   return results.map((res) => RestaurantElement.fromJson(res)).toList();
  // }

  Future<Map> getUserByEmailPassword(String email, String password) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblUsers,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    print('hasil');
    print(email);
    print(password);
    print(results);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  // Future<void> removeFavourite(String id) async {
  //   final db = await database;

  //   await db!.delete(
  //     _tblUsers,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }
}
