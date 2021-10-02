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
        print(element.fields);
        _data.add(element.fields);
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
        _data.add(element.fields);
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
