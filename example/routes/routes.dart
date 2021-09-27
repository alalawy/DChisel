import 'package:dchisel/dchisel.dart';

class Routes {
  Future<void> routes() async {
    DChiselDB().configDB(
        host: 'localhost',
        db: 'dart_test',
        port: 5432,
        username: 'postgres',
        password: '14091996Aa`'); // DB CONFIGURATION

    DChisel().routeGet('/', (Request request) {
      return DChiselDB().getAll('users');
    });
    DChisel().routeGet('/users', (Request request) {
      return DChiselDB().getAll('users');
    });
    DChisel().routeGet('/users/<name>', (Request request, String name) {
      return DChiselDB()
          .getOption('users', colum: 'email', where: ['name', '%$name%']);
    });
    DChisel().routePost('/users/add', (Request request) async {
      return DChiselDB().create('users', data: await request.body.asJson);
    });
    DChisel().routeDelete('/users/<id>', (Request request, String id) {
      return DChiselDB().deleteOption('users', where: ['id', int.parse(id)]);
    });
    DChisel().routeDelete('/deleteall/users', (Request request) {
      return DChiselDB().deleteAll('users');
    });
    DChisel().routePut('/users/<id>', (Request request, String id) async {
      return DChiselDB().update('users',
          data: await request.body.asJson, where: ['id', int.parse(id)]);
    });
    //ROUTES
  }
}
