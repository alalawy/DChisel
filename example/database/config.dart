import 'package:dchisel/dchisel.dart';

class Database {
  void config() {
    DChiselDB().configDB('mysql',
        host: 'localhost',
        db: 'dchisel',
        port: 3306,
        username: 'root',
        password: '14091996Aa');
  }
}
