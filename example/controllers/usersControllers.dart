import 'dart:convert';

import 'package:dchisel/dchisel.dart';

class UsersControllers {
  Future<Response> getUser(Request request) async {
    //final authDetails = request.context['authDetails'] as JWT;
    // var user = await DChiselDB()
    //     .getOption('users', where: ['salt', authDetails.payload['salt']]);
    var users = await DChiselDB().getAll('users');
    // var dta = jsonDecode(await users.readAsString());
    // print(dta['data']);
    return users;

    // // Map<String, dynamic> users = await DChiselDB().query('users',
    // //     queries: 'select * from users where id = @id', values: {'id': 1});
    // if (user.context .da[0]['hak_akses'] == 'admin') {
    //   return resOk(users['data']);
    // } else {
    //   return resForbidden('Not have permission to access data');
    // }
  }
}
