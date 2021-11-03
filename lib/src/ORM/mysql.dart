import 'package:dchisel/src/ORM/utils.dart';
import 'package:mysql1/mysql1.dart';

class MySql {
  Future<Map<String, dynamic>> getAll(
      MySqlConnection? connection, table) async {
    var errorData = 0;
    var errorMessage;
    var val;
    var _data = <Map<String, dynamic>>[];

    await connection!.query('select * from $table');
    var dataQuery = connection.query('select * from $table');

    await dataQuery.then((value) {
      val = value;
    }).onError((error, stackTrace) => null);

    if (val.isNotEmpty) {
      val.forEach((element) {
        _data.add(encodeMap(element.field));
      });
    }
    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }

  Future<Map<String, dynamic>> getOption(MySqlConnection? connection, table,
      {required String column, required List where}) async {
    var errorData = 0;
    var errorMessage;
    var val;
    var _data = <Map<String, dynamic>>[];

    await connection!.query(
        'select $column from $table where ${where[0]} like ?', [where[1]]);
    var dataQuery = connection.query(
        'select $column from $table where ${where[0]} like ?', [where[1]]);

    await dataQuery.then((value) {
      val = value;
    }).onError((error, stackTrace) => null);

    if (val.isNotEmpty) {
      val.forEach((element) {
        _data.add(encodeMap(element.field));
      });
    }
    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }

  Future<Map<String, dynamic>> create(MySqlConnection connection, table,
      {required Map<String, dynamic>? data}) async {
    var errorData = 0;
    var errorMessage;
    var val;
    var _data = <Map<String, dynamic>>[];
    List? values = [];

    data!.values.toList().forEach((element) {
      values.add('?');
    });

    var whereValues = values
        .toString()
        .replaceFirst('[', '(')
        .substring(0, values.toString().length - 1);

    var dataQuery = connection.query(
        'insert into $table ${data.keys} values $whereValues)',
        data.values.toList());

    await dataQuery.then((value) {
      val = value;
    }).onError((error, stackTrace) => null);

    if (val.isNotEmpty) {
      val.forEach((element) {
        _data.add(encodeMap(element.field));
      });
    }
    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }

  Future<Map<String, dynamic>> deleteAll(
      MySqlConnection connection, table) async {
    var errorData = 0;
    var errorMessage;
    var val;
    var _data = <Map<String, dynamic>>[];

    var dataQuery = connection.query('delete from $table');

    await dataQuery.then((value) {
      val = value;
    }).onError((error, stackTrace) => null);

    if (val.isNotEmpty) {
      val.forEach((element) {
        _data.add(encodeMap(element.field));
      });
    }

    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }

  Future<Map<String, dynamic>> deleteOption(MySqlConnection connection, table,
      {required List? where}) async {
    var errorData = 0;
    var errorMessage;
    var val;
    var _data = <Map<String, dynamic>>[];

    await connection
        .query('delete from $table where ${where![0]} = ?', [where[1]]);
    var dataQuery = connection
        .query('delete from $table where ${where[0]} = ?', [where[1]]);

    await dataQuery.then((value) {
      val = value;
    }).onError((error, stackTrace) => null);

    if (val.isNotEmpty) {
      val.forEach((element) {
        _data.add(encodeMap(element.field));
      });
    }

    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }

  Future<Map<String, dynamic>> update(MySqlConnection connection, table,
      {required Map<String, dynamic>? data, required List? where}) async {
    var errorData = 0;
    var errorMessage;
    var val;
    var _data = <Map<String, dynamic>>[];
    var _dataMap = <String, dynamic>{};
    List? whereValues = [];

    data!.forEach((key, value) {
      var _key = key;
      var _value;
      if (value.runtimeType == String) {
        _value = '\'$value\'';
      } else {
        _value = value;
      }
      _key = key.replaceAll(key, '$key=?');
      _dataMap[_key] = value;
      whereValues.add(value);
    });

    var setData = _dataMap.keys
        .toString()
        .replaceFirst('(', '')
        .substring(0, _dataMap.keys.toString().length - 2);

    whereValues.add(where![1]);

    await connection.query(
        'update $table set $setData where ${where[0]} = ?', whereValues);
    var dataQuery = connection.query(
        'update $table set $setData where ${where[0]} = ?', whereValues);

    await dataQuery.then((value) {
      val = value;
    }).onError((error, stackTrace) => null);

    if (val.isNotEmpty) {
      val.forEach((element) {
        _data.add(encodeMap(element.field));
      });
    }

    var _base = {
      'error': errorData,
      'data': _data,
      'message': errorMessage ?? 'Success'
    };
    return _base;
  }
}
