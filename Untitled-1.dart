/*Future<Map<String, dynamic>> create(table,
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

  Future<Map<String, dynamic>> deleteAll(table) async {
    List<Map<String, dynamic>>? resultMap;

    var _data = <Map<String, dynamic>>[];

    var connection = PostgreSQLConnection(_host, _port, _db,
        username: _username, password: _password);
    await connection.open();

    await connection.mappedResultsQuery('DELETE FROM $table').then((value1) {
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

  Future<Map<String, dynamic>> deleteOption(table,
      {required List? where}) async {
    List<Map<String, dynamic>>? resultMap;

    var _data = <Map<String, dynamic>>[];

    var connection = PostgreSQLConnection(_host, _port, _db,
        username: _username, password: _password);
    await connection.open();

    await connection.mappedResultsQuery(
        'DELETE FROM $table WHERE ${where![0]} = @value',
        substitutionValues: {'value': where[1]}).then((value1) {
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

  Future<Map<String, dynamic>> update(table,
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

    var connection = PostgreSQLConnection(_host, _port, _db,
        username: _username, password: _password);

    await connection.open();

    await connection.mappedResultsQuery(
        'UPDATE $table SET $setData WHERE ${where![0]} = @value',
        substitutionValues: {'value': where[1]}).then((value1) {
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
  }*/