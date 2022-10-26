import 'package:dchisel/dchisel.dart';
import 'package:postgres/postgres.dart';

class Postgre {
  bool errorData = false;
  var errorMessage;

  Future<Response> getAll(PostgreSQLConnection connection, table) async {
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];

    await connection.mappedResultsQuery('SELECT * FROM $table').then((value1) {
      resultMap = value1;
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(encodeMap(row[table] ?? {'': ''}));
      }
    }

    // var _base = {
    //   'error': errorData,
    //   'data': _data,
    //   'message': errorMessage ?? 'Success'
    // };

    return errorData ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> getOption(PostgreSQLConnection connection, table,
      {column, where}) async {
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];
    print('SELECT $column FROM $table WHERE ${where[0]} LIKE ${where[1]}');
    where != null
        ? await connection.mappedResultsQuery(
            'SELECT $column FROM $table WHERE ${where[0]} LIKE @value',
            substitutionValues: {'value': where[1]}).then((value1) {
            resultMap = value1;
          }).onError((error, stackTrace) {
            errorData = true;
            errorMessage = error.toString();
          })
        : await connection
            .mappedResultsQuery('SELECT $column FROM $table')
            .then((value1) {
            resultMap = value1;
          }).onError((error, stackTrace) {
            errorData = true;
            errorMessage = error.toString();
          });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(encodeMap(row[table] ?? {'': ''}));
      }
    }
    return errorData ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> create(PostgreSQLConnection connection, table,
      {required Map<String, dynamic>? data}) async {
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];
    var _dataMap = <String, dynamic>{};

    data!.forEach((key, value) {
      var _key = key;
      _key = key.replaceAll(key, '@$key');
      _dataMap[_key] = value;
    });

    await connection
        .mappedResultsQuery(
            'INSERT INTO $table ${data.keys} VALUES ${_dataMap.keys}',
            substitutionValues: data)
        .then((value1) {
      resultMap = value1;
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(encodeMap(row[table] ?? {'': ''}));
      }
    }
    return errorData ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> deleteAll(PostgreSQLConnection connection, table) async {
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];

    await connection.mappedResultsQuery('DELETE FROM $table').then((value1) {
      resultMap = value1;
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(encodeMap(row[table] ?? {'': ''}));
      }
    }
    return errorData ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> deleteOption(PostgreSQLConnection connection, table,
      {required List? where}) async {
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];

    await connection.mappedResultsQuery(
        'DELETE FROM $table WHERE ${where![0]} = @value',
        substitutionValues: {'value': where[1]}).then((value1) {
      resultMap = value1;
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(encodeMap(row[table] ?? {'': ''}));
      }
    }
    return errorData ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> update(PostgreSQLConnection connection, table,
      {required Map<String, dynamic>? data, required List? where}) async {
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];
    var _dataMap = <String, dynamic>{};

    data!.forEach((key, value) {
      var _key = key;
      var _value;
      if (value.runtimeType == String) {
        _value = '\'$value\'';
      } else {
        _value = value;
      }
      _key = key.replaceAll(key, '$key=$_value');
      _dataMap[_key] = value;
    });

    var setData = _dataMap.keys
        .toString()
        .replaceFirst('(', '')
        .substring(0, _dataMap.keys.toString().length - 2);

    await connection.mappedResultsQuery(
        'UPDATE $table SET $setData WHERE ${where![0]} = @value',
        substitutionValues: {'value': where[1]}).then((value1) {
      resultMap = value1;
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    if (resultMap != null) {
      for (final row in resultMap!) {
        _data.add(encodeMap(row[table] ?? {'': ''}));
      }
    }
    return errorData ? resForbidden(errorMessage) : resOk(_data);
  }
}
