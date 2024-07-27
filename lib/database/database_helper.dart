import 'package:path/path.dart';
import 'package:pihole_manager/models/server_details.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String _databaseName = 'piHoleManager.db';
  final int _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute(ServerDetails.createTable);
  }

  Future<void> addServer(ServerDetails server) async {
    final Database db = await instance.database;
    await db.insert(
      ServerDetails.tableName,
      server.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ServerDetails>> getAllServer() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(ServerDetails.tableName);

    return maps.map((e) => ServerDetails.fromMap(e)).toList();
  }

  Future<ServerDetails?> getServer(String host) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      ServerDetails.tableName,
      where: '${ServerDetails.hostColumn} = ?',
      whereArgs: [host],
    );
    if (maps.isNotEmpty) {
      return ServerDetails.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateServer(ServerDetails server) async {
    final Database db = await instance.database;
    return await db.update(
      ServerDetails.tableName,
      server.toMap(),
      where: '${ServerDetails.hostColumn} = ?',
      whereArgs: [server.host],
    );
  }

  Future<int> deleteServer(String host) async {
    final Database db = await instance.database;
    return await db.delete(
      ServerDetails.tableName,
      where: '${ServerDetails.hostColumn} = ?',
      whereArgs: [host],
    );
  }
}
