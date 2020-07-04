import 'package:curso_1/application.dart';
import 'package:sqflite/sqflite.dart';

abstract class AbstractModel {
  Database _db;
  String get dbName;
  int get dbVersion;

  Future<Database> init() async {
    if (this._db == null) {
      var databasePath = await getDatabasesPath();
      String path = databasePath + dbName;
      
      // limpar o banco
      // await deleteDatabase(path);

      this._db = await openDatabase(path, version: dbVersion, 
      onCreate: (Database db, int version) async {
        dbCreate.forEach((String sql) {
          db.execute(sql);
        });
      });

    }
    return this._db;
  }

  Future<Database> getDB() async {
    return await this.init();
  }

}