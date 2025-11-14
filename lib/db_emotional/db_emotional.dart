
import 'package:emotional_release/db_emotional/emotional_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBEmotional extends GetxService {
  late Database dbBase;

  Future<DBEmotional> init() async {
    await createEmotionalDB();
    return this;
  }

  createEmotionalDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'emotional.db');

    dbBase = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
          await createEmotionalTable(db);
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (oldVersion < 2) {
            await db.execute('DROP TABLE IF EXISTS emotional');
            await createEmotionalTable(db);
          }
        });
  }

  createEmotionalTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS emotional (id INTEGER PRIMARY KEY, createdTime TEXT, type INTEGER, content TEXT, intensity INTEGER, triggers TEXT, physicalFeelings TEXT, reflection TEXT, reflectionTime TEXT)');
  }

  insertEmotional(EmotionalEntity entity) async {
    final entityMap = entity.toJson();
    entityMap.remove('id');
    final id = await dbBase.insert('emotional', entityMap);
    return id;
  }

  cleanEmotionalData() async {
    await dbBase.delete('emotional');
  }

  Future<List<EmotionalEntity>> getEmotionalAllData() async {
    var result = await dbBase.query('emotional', orderBy: 'createdTime DESC');
    return result.map((e) => EmotionalEntity.fromJson(e)).toList();
  }

  updateReflection(int id, String reflection) async {
    await dbBase.update(
      'emotional',
      {
        'reflection': reflection,
        'reflectionTime': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<EmotionalEntity>> getEmotionalDataByDateRange(
      DateTime start, DateTime end) async {
    var result = await dbBase.query(
      'emotional',
      where: 'createdTime >= ? AND createdTime <= ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'createdTime DESC',
    );
    return result.map((e) => EmotionalEntity.fromJson(e)).toList();
  }

  Future<List<EmotionalEntity>> getEmotionalDataByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return getEmotionalDataByDateRange(startOfDay, endOfDay);
  }
}
