import 'package:dchisel/dchisel.dart';

import '../controllers/usersControllers.dart';

class UsersRoutes {
  DRoute route(prefix, droute) {
    droute.get('/', (Request req) async => UsersControllers().getUser(req),
        prefix: prefix);
    droute.get(
        '/<username>',
        (Request req, String username) async => await DChiselDB()
            .getOption('users', where: ['username', '%$username%']),
        prefix: prefix);
    droute.post('/add', (Request request) async {
      var jsonData = await request.body.asJson;
      jsonData['password'] = hashPassword(jsonData['password'], 'salt');
      return DChiselDB().create('users', data: jsonData);
    }, prefix: prefix);

    droute.put('/update/<id>', (Request request, String id) async {
      var jsonData = await request.body.asJson;
      return DChiselDB().update('users', data: jsonData, where: ['id', id]);
    }, prefix: prefix);

    return droute;
  }
}

var users = UsersRoutes();
