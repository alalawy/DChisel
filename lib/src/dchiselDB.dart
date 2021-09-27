import 'package:postgres/postgres.dart';

var errorData = 0;
var errorMessage;
var _host = 'localhost';
var _port = 5432;
var _db = '';
var _username = '';
var _password = '';

class DChiselDB {
  void configDB({host, port, db, username, password}) {
    _host = host;
    _port = port;
    _db = db;
    _username = username;
    _password = password;
  }

  Future<Map<String, dynamic>> getAll(table) async {
    List<Map<String, dynamic>>? resultMap;

    var _data = <Map<String, dynamic>>[];

    var connection = PostgreSQLConnection(_host, _port, _db,
        username: _username, password: _password);
    await connection.open();

    await connection.mappedResultsQuery('SELECT * FROM $table').then((value1) {
      resultMap = value1;
    }).onError((error, stackTrace) {
      errorData = 1;
      errorMessage = error.toString();
    });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(row[table] ?? {'': ''});
      }
    }
    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }

  Future<Map<String, dynamic>> getOption(table,
      {colum = '*', List? where}) async {
    List<Map<String, dynamic>>? resultMap;

    var _data = <Map<String, dynamic>>[];

    var connection = PostgreSQLConnection(_host, _port, _db,
        username: _username, password: _password);
    await connection.open();

    where != null
        ? await connection.mappedResultsQuery(
            'SELECT $colum FROM $table WHERE ${where[0]} LIKE @value',
            substitutionValues: {'value': where[1]}).then((value1) {
            resultMap = value1;
          }).onError((error, stackTrace) {
            errorData = 1;
            errorMessage = error.toString();
          })
        : await connection
            .mappedResultsQuery('SELECT $colum FROM $table')
            .then((value1) {
            resultMap = value1;
          }).onError((error, stackTrace) {
            errorData = 1;
            errorMessage = error.toString();
          });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(row[table] ?? {'': ''});
      }
    }
    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }

  Future<Map<String, dynamic>> create(table,
      {required Map<String, dynamic>? data}) async {
    List<Map<String, dynamic>>? resultMap;

    var _data = <Map<String, dynamic>>[];
    var _dataMap = <String, dynamic>{};

    data!.forEach((key, value) {
      var _key = key;
      _key = key.replaceAll(key, '@$key');
      _dataMap[_key] = value;
    });

    var connection = PostgreSQLConnection(_host, _port, _db,
        username: _username, password: _password);

    await connection.open();

    await connection
        .mappedResultsQuery(
            'INSERT INTO $table ${data.keys} VALUES ${_dataMap.keys}',
            substitutionValues: data)
        .then((value1) {
      resultMap = value1;
    }).onError((error, stackTrace) {
      errorData = 1;
      errorMessage = error.toString();
    });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(row[table] ?? {'': ''});
      }
    }
    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }
}
