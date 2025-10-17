import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/activity.dart';
import 'database_service.dart';

class SqliteService implements DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'fitness_tracker.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE activities (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NOT NULL,
      duration INTEGER NOT NULL,
      calories INTEGER NOT NULL,
      steps INTEGER NOT NULL,
      timestamp INTEGER NOT NULL
    )
    ''');
  }

  @override
  Future<void> addActivity(Activity activity) async {
    final db = await database;
    await db.insert(
      'activities',
      activity.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Activity>> getActivities() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'activities',
      orderBy: 'timestamp DESC',
    );
    return List.generate(maps.length, (i) {
      return Activity.fromDbMap(maps[i]);
    });
  }

  // --- NEW METHOD ---
  // Implements the actual database update operation using the activity's ID.
  @override
  Future<void> updateActivity(Activity activity) async {
    final db = await database;
    await db.update(
      'activities',
      activity.toDbMap(),
      where: 'id = ?',
      whereArgs: [
        int.tryParse(activity.id!),
      ], // Use the ID to find the correct row
    );
  }

  @override
  Future<void> deleteActivity(String id) async {
    final db = await database;
    await db.delete('activities', where: 'id = ?', whereArgs: [int.parse(id)]);
  }
}
