import 'package:dchisel/src/ORM/mysql.dart';
import 'package:dchisel/src/ORM/postgre.dart';
import 'package:mysql1/mysql1.dart';
import 'package:postgres/postgres.dart';

var _host = 'localhost';
var _port = 5432;
var _db = '';
var _username = '';
var _password = '';
var _database = '';

class DChiselDB {
  void configDB(database, {host, port, db, username, password}) {
    _database = database;
    _host = host;
    _port = port;
    _db = db;
    _username = username;
    _password = password;
  }

  Future<Map<String, dynamic>> getAll(table) async {
    var db;
    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = Postgre().getAll(connection, table);
    } else if (_database == 'mysql') {
      // ignore: unnecessary_new
      var settings = new ConnectionSettings(
          host: _host,
          port: _port,
          user: _username,
          password: _password,
          db: _db);
      var connection = await MySqlConnection.connect(settings);
      db = await MySql().getAll(connection, table);
    } else {}

    return db;
  }

  Future<Map<String, dynamic>> getOption(table,
      {column = '*', List? where}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre()
          .getOption(connection, table, column: column, where: where);
    } else if (_database == 'mysql') {
      // ignore: unnecessary_new
      var settings = new ConnectionSettings(
          host: _host,
          port: _port,
          user: _username,
          password: _password,
          db: _db);
      var connection = await MySqlConnection.connect(settings);
    } else {}

    return db;
  }

  Future<Map<String, dynamic>> create(table,
      {required Map<String, dynamic>? data}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().create(connection, table, data: data);
    } else if (_database == 'mysql') {
      // ignore: unnecessary_new
      var settings = new ConnectionSettings(
          host: _host,
          port: _port,
          user: _username,
          password: _password,
          db: _db);
      var connection = await MySqlConnection.connect(settings);
    } else {}

    return db;
  }

  Future<Map<String, dynamic>> deleteAll(table) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().deleteAll(connection, table);
    } else if (_database == 'mysql') {
      // ignore: unnecessary_new
      var settings = new ConnectionSettings(
          host: _host,
          port: _port,
          user: _username,
          password: _password,
          db: _db);
      var connection = await MySqlConnection.connect(settings);
    } else {}

    return db;
  }

  Future<Map<String, dynamic>> deleteOption(table,
      {required List? where}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().deleteOption(connection, table, where: where);
    } else if (_database == 'mysql') {
      // ignore: unnecessary_new
      var settings = new ConnectionSettings(
          host: _host,
          port: _port,
          user: _username,
          password: _password,
          db: _db);
      var connection = await MySqlConnection.connect(settings);
    } else {}

    return db;
  }

  Future<Map<String, dynamic>> update(table,
      {required Map<String, dynamic>? data, required List? where}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().update(connection, table, data: data, where: where);
    } else if (_database == 'mysql') {
      // ignore: unnecessary_new
      var settings = new ConnectionSettings(
          host: _host,
          port: _port,
          user: _username,
          password: _password,
          db: _db);
      var connection = await MySqlConnection.connect(settings);
    } else {}

    return db;
  }
}
