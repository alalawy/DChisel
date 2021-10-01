class Postgre {
  Future<Map<String, dynamic>> getAll(connection, table) async {
    var errorData = 0;
    var errorMessage;
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];

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

  Future<Map<String, dynamic>> getOption(connection, table,
      {column, where}) async {
    var errorData = 0;
    var errorMessage;
    List<Map<String, dynamic>>? resultMap;
    var _data = <Map<String, dynamic>>[];
    where != null
        ? await connection.mappedResultsQuery(
            'SELECT $column FROM $table WHERE ${where[0]} LIKE @value',
            substitutionValues: {'value': where[1]}).then((value1) {
            resultMap = value1;
          }).onError((error, stackTrace) {
            errorData = 1;
            errorMessage = error.toString();
          })
        : await connection
            .mappedResultsQuery('SELECT $column FROM $table')
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
