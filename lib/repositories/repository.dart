import 'package:sqflite/sqflite.dart';
import 'package:todo_app/repositories/database_connection.dart';

class Repository {
  DatabaseConnection? _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  // check if database is exist or not
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection!.setDatabase();
    return _database;
  }

  // inserting data to table
  insertData(table, data) async {
    var connection = await database;
    return await connection!.insert(table, data);
  }

  // update data from table by id
  updateData(table, data) async {
    var connection = await database;
    return await connection!
        .update(table, data, where: 'id= ?', whereArgs: [data['id']]);
  }

  // delete data from table by id
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection!.rawDelete("DELETE FROM $table WHERE id= $itemId");
  }

  // read data from table
  readData(table) async {
    var connection = await database;
    return await connection!.query(table);
  }

  //  read data from table by id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [itemId]);
  }
}
