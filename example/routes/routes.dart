import 'package:dchisel/dchisel.dart';

import '../database/config.dart';
import 'usersRoutes.dart';

class Routes {
  DRoute route() {
    Database().config();
    var droute = DRoute();
    droute.get('/', (Request req) async => resOk("Hello, DChisel"));
    users.route('/users', droute);

    return droute;
  }

  Future<void> routes() async {
    // DChiselDB().configDB('postgre',
    //     host: 'localhost',
    //     db: 'dart_test',
    //     port: 5432,
    //     username: 'postgres',
    //     password: '14091996Aa`'); // DB CONFIGURATION

    /*DChiselDB().configDB('mysql',
        host: '127.0.0.1',
        db: 'dart_coba',
        port: 3306,
        username: 'root',
        password: '14091996Aa`');*/

    // DRoute().get('/', (Request request) {
    //   return "alawyaa";
    //   //return DChiselDB().getAll('users');
    // }); // GET ALL DATA USERS FROM DB

    // DChisel().routeGet('/users', (Request request) {
    //   return DChiselDB().getAll('users');
    // }); // GET ALL DATA USERS FROM DB

    // DChisel().routeGet('/users/<name>', (Request request, String name) async {
    //   var user = await DChiselDB()
    //       .getOption('users', column: 'email', where: ['name', '$name']);
    //   print(user);
    //   return user;
    // }); // GET ONE DATA USERS FROM DB EITH FILTER BY NAME

    // DChisel().routePost('/users/add', (Request request) async {
    //   return DChiselDB().create('users', data: await request.body.asJson);
    // }); // CREATE NEW USERS

    // DChisel().routeDelete('/users/<id>', (Request request, String id) {
    //   return DChiselDB().deleteOption('users', where: ['id', int.parse(id)]);
    // }); // DELETE USERS BY ID

    // DChisel().routeDelete('/deleteall/users', (Request request) {
    //   return DChiselDB().deleteAll('users');
    // }); // DELETE ALL USERS

    // DChisel().routePut('/users/<id>', (Request request, String id) async {
    //   return DChiselDB().update('users',
    //       data: await request.body.asJson, where: ['id', int.parse(id)]);
    // }); // UPDATE USERS BY ID

    //ROUTES
  }
}
