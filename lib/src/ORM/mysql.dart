class MySql {
  Future<Map<String, dynamic>> getAll(connection, table) async {
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
  }
}
