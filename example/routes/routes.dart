import 'package:dart_chisel/dchisel.dart';

class Routes {
  void routes() {
    DChiselDB().configDB(
        host: 'localhost',
        db: 'dart_test',
        port: 5432,
        username: 'postgres',
        password: '14091996Aa`'); // DB CONFIGURATION

    DChisel().routeGet('/', (Request request) {
      return DChiselDB().getAll('users');
    });
    DChisel().routeGet('/users/<name>', (Request request, String name) {
      return DChiselDB()
          .getOption('users', colum: 'email', where: ['name', '%$name%']);
    }); //ROUTES
  }
}
