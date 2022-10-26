import 'package:dchisel/dchisel.dart';
import 'package:dchisel/src/ORM/mysql.dart';
import 'package:dchisel/src/ORM/postgre.dart';
import 'package:mysql_client/mysql_client.dart';
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

  Future<Response> getAll(table) async {
    var db;
    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = Postgre().getAll(connection, table);
    } else if (_database == 'mysql') {
      final connection = await MySQLConnection.createConnection(
        host: _host,
        port: _port,
        userName: _username,
        password: _password,
        databaseName: _db, // optional
      );

      await connection.connect();
      db = await MySql().getAll(connection, table);
    } else {}

    return db;
  }

  Future<Response> getOption(table, {column = '*', List? where}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre()
          .getOption(connection, table, column: column, where: where);
    } else if (_database == 'mysql') {
      final connection = await MySQLConnection.createConnection(
        host: _host,
        port: _port,
        userName: _username,
        password: _password,
        databaseName: _db, // optional
      );

      await connection.connect();
      db = await MySql()
          .getOption(connection, table, column: column, where: where!);
    } else {}

    return db;
  }

  Future<Response> create(table, {required Map<String, dynamic>? data}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().create(connection, table, data: data);
    } else if (_database == 'mysql') {
      final connection = await MySQLConnection.createConnection(
        host: _host,
        port: _port,
        userName: _username,
        password: _password,
        databaseName: _db, // optional
      );

      await connection.connect();
      db = await MySql().create(connection, table, data: data);
    } else {}

    return db;
  }

  Future<Response> deleteAll(table) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().deleteAll(connection, table);
    } else if (_database == 'mysql') {
      final connection = await MySQLConnection.createConnection(
        host: _host,
        port: _port,
        userName: _username,
        password: _password,
        databaseName: _db, // optional
      );

      await connection.connect();
      db = await MySql().deleteAll(connection, table);
    } else {}

    return db;
  }

  Future<Response> deleteOption(table, {required List? where}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().deleteOption(connection, table, where: where);
    } else if (_database == 'mysql') {
      // ignore: unnecessary_new
      final connection = await MySQLConnection.createConnection(
        host: _host,
        port: _port,
        userName: _username,
        password: _password,
        databaseName: _db, // optional
      );

      await connection.connect();
      db = await MySql().deleteOption(connection, table, where: where);
    } else {}

    return db;
  }

  Future<Response> update(table,
      {required Map<String, dynamic>? data, required List? where}) async {
    var db;

    if (_database == 'postgre') {
      var connection = PostgreSQLConnection(_host, _port, _db,
          username: _username, password: _password);
      await connection.open();
      db = await Postgre().update(connection, table, data: data, where: where);
    } else if (_database == 'mysql') {
      final connection = await MySQLConnection.createConnection(
        host: _host,
        port: _port,
        userName: _username,
        password: _password,
        databaseName: _db, // optional
      );

      await connection.connect();
      db = await MySql().update(connection, table, data: data, where: where);
    } else {}

    return db;
  }
}
