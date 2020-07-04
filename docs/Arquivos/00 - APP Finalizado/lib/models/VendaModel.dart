import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../application.dart';
import 'databaseAbstract.dart';

class ModelVenda extends AbstractModel {

  ///
  /// Singleton
  ///

  static ModelVenda _this;

  factory ModelVenda() {
    if (_this == null) {
      _this = ModelVenda.getInstance();
    }
    return _this;
  }

  ModelVenda.getInstance() : super();

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
    return db.rawQuery('''
      SELECT
        V.*,
        (
          SELECT COUNT(1)
          FROM produtos as i
          WHERE i.fk_venda = V.pk_venda
        ) as qtdProdutos
      FROM vendas as V
      ORDER BY V.data DESC
    ''');
  }

  @override
  Future<Map> getItem(dynamic where) async {
    Database db = await this.getDb();
    List<Map> vendas = await db.query('vendas', where: 'pk_venda = ?', whereArgs: [where], limit: 1);

    Map result = Map();
    if (vendas.isNotEmpty) {
      result = vendas.first;
    }
    return result;
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async {
    Database db = await this.getDb();
    int newId = await db.insert('vendas', values);

    return newId;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, where) async {

    Database db = await this.getDb();
    int rows = await db.update('vendas', values, where: 'pk_venda = ?', whereArgs: [where]);

    return (rows != 0);
  }

  @override
  Future<bool> delete(dynamic id) async {
    Database db = await this.getDb();
    int rows = await db.delete('vendas', where: 'pk_venda = ?', whereArgs: [id]);

    return (rows != 0);
  }

}