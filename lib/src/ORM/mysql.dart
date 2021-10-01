class MySql {
  Future<Map<String, dynamic>> getAll(connection, table) async {
    var errorData = 0;
    var errorMessage;
    var val;
    var _data = <Map<String, dynamic>>[];

    await connection.query('select * from users').then((value1) {
      val = value1;
    }).onError((error, stackTrace) {
      errorData = 1;
      errorMessage = error.toString();
    });

    if (val != null) {
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
