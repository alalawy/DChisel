import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_plus/shelf_plus.dart';

var errorData = 0;
var errorMessage;

var _host = 'localhost';
var _port = 5432;
var _db = '';
var _username = '';
var _password = '';

var _routeGet = [];
var _routePost = [];
var _routePut = [];
var _routeDelete = [];
var _routePatch = [];
List<Function> _dataHandlerGet = [];
List<Function> _dataHandlerPost = [];
List<Function> _dataHandlerPut = [];
List<Function> _dataHandlerDelete = [];
List<Function> _dataHandlerPatch = [];

List<Map<String, dynamic>>? base = [];

class DChisel {
  void routeGet(String route, Function data) {
    _routeGet.add(route);
    _dataHandlerGet.add(data);
  }

  void routePost(String route, Function data) {
    _routePost.add(route);
    _dataHandlerPost.add(data);
  }

  void routePut(String route, Function data) {
    _routePut.add(route);
    _dataHandlerPut.add(data);
  }

  void routeDelete(String route, Function data) {
    _routeDelete.add(route);
    _dataHandlerDelete.add(data);
  }

  void routePatch(String route, Function data) {
    _routePatch.add(route);
    _dataHandlerPatch.add(data);
  }

  Future<void> serve({serverHost, serverPort}) async {
    var routes = Router().plus;

    RouterPlus routerData() {
      for (var i = 0; i < _routeGet.length; i++) {
        routes.get(_routeGet[i], _dataHandlerGet[i]);
      }
      for (var i = 0; i < _routePost.length; i++) {
        routes.post(_routePost[i], _dataHandlerPost[i]);
      }
      for (var i = 0; i < _routePut.length; i++) {
        routes.put(_routePut[i], _dataHandlerPut[i]);
      }
      for (var i = 0; i < _routeDelete.length; i++) {
        routes.delete(_routeDelete[i], _dataHandlerDelete[i]);
      }
      for (var i = 0; i < _routePatch.length; i++) {
        routes.delete(_routePatch[i], _dataHandlerPatch[i]);
      }

      return routes;
    }

    var server = await io.serve(
        routerData(), serverHost ?? 'localhost', serverPort ?? 8000);

    print('Serving at http://${server.address.host}:${server.port}');
  }
}

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
