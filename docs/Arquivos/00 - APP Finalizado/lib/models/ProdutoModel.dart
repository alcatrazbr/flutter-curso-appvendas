import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../application.dart';
import 'databaseAbstract.dart';

class ModelProduto extends AbstractModel {

  ///
  /// Singleton
  ///

  static ModelProduto _this;

  factory ModelProduto() {
    if (_this == null) {
      _this = ModelProduto.getInstance();
    }
    return _this;
  }

  ModelProduto.getInstance() : super();

  ///
  /// The Instance
  ///

  @override
  String get dbname => dbName;

  @override
  int get dbversion => dbVersion;


  @override
  Future<List<Map>> list() async {
    Database db = await this.getDb();
    return db.rawQuery('SELECT * FROM produtos ORDER BY data DESC');
  }

  /// Retorna todos os produtos da lista com base em uma consulta
  ///

  Future<List<Map>> itemsByList(int fkVenda) async {
    Database db = await this.getDb();
    return db.rawQuery('SELECT * FROM produtos WHERE fk_venda = $fkVenda ORDER BY nome ASC, data DESC');
  }


  @override
  Future<Map> getItem(dynamic where) async {
    Database db = await this.getDb();
    List<Map> vendas = await db.query('produtos', where: 'pk_produto = ?', whereArgs: [where], limit: 1);

    Map result = Map();
    if (vendas.isNotEmpty) {
      result = vendas.first;
    }
    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async {
    Database db = await this.getDb();
    int newId = await db.insert('produtos', values);

    return newId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async {

    Database db = await this.getDb();
    int rows = await db.update('produtos', values, where: 'pk_produto = ?', whereArgs: [where]);

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic id) async {
    Database db = await this.getDb();
    int rows = await db.delete('produtos', where: 'pk_produto = ?', whereArgs: [id]);

    return (rows != 0);
  }

}