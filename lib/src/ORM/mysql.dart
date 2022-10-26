import 'package:dchisel/dchisel.dart';
import 'package:mysql_client/mysql_client.dart';

class MySql {
  bool? errorData = false;
  var errorMessage;
  Future<Response> getAll(MySQLConnection? connection, table) async {
    var val;
    var _data = <Map<String, dynamic>>[];

    var dataQuery = connection?.execute('select * from $table');

    await dataQuery!.then((value) {
      for (final row in value.rows) {
        _data.add(encodeMap(row.assoc()));
      }
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    return errorData! ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> getOption(MySQLConnection? connection, table,
      {required String column, required List where}) async {
    var val;
    var _data = <Map<String, dynamic>>[];

    var dataQuery = connection?.execute(
        'select $column from $table where ${where[0]} like :${where[0]}',
        {'${where[0]}': '${where[1]}'});

    await dataQuery!.then((value) {
      for (final row in value.rows) {
        _data.add(encodeMap(row.assoc()));
      }
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    return errorData! ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> create(MySQLConnection? connection, table,
      {required Map<String, dynamic>? data}) async {
    var val;
    var _data = <Map<String, dynamic>>[];
    List? values = [];

    data!.keys.toList().forEach((element) {
      values.add('?');
    });

    var whereValues = values
        .toString()
        .replaceFirst('[', '')
        .substring(0, values.toString().length - 2);

    // print(whereValues);
    // print(
    //     'insert into $table ${data.keys} values $whereValues, ${data.values.toList()}');
    var stmt = await connection?.prepare(
      'insert into $table ${data.keys} values ($whereValues)',
    );
    var dataQuery = stmt!.execute(data.values.toList());

    await dataQuery.then((value) {
      for (final row in value.rows) {
        _data.add(encodeMap(row.assoc()));
      }
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });
    return errorData! ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> deleteAll(MySQLConnection? connection, table) async {
    var val;
    var _data = <Map<String, dynamic>>[];

    var dataQuery = connection?.execute('delete from $table');

    await dataQuery!.then((value) {
      for (final row in value.rows) {
        _data.add(encodeMap(row.assoc()));
      }
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    return errorData! ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> deleteOption(MySQLConnection? connection, table,
      {required List? where}) async {
    var val;
    var _data = <Map<String, dynamic>>[];

    var dataQuery = connection?.execute(
        'delete from $table where ${where![0]} = :${where[0]}',
        {where[0]: where[1]});

    await dataQuery!.then((value) {
      for (final row in value.rows) {
        _data.add(encodeMap(row.assoc()));
      }
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    return errorData! ? resForbidden(errorMessage) : resOk(_data);
  }

  Future<Response> update(MySQLConnection? connection, table,
      {required Map<String, dynamic>? data, required List? where}) async {
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
    // print('update $table set $setData where ${where[0]} = ?');
    // print(whereValues);
    var stmt = await connection?.prepare(
      'update $table set $setData where ${where[0]} = ?',
    );
    var dataQuery = stmt!.execute(whereValues);

    await dataQuery.then((value) {
      for (final row in value.rows) {
        _data.add(encodeMap(row.assoc()));
      }
    }).onError((error, stackTrace) {
      errorData = true;
      errorMessage = error.toString();
    });

    return errorData! ? resForbidden(errorMessage) : resOk(_data);
  }
}
