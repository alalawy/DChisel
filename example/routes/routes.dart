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
}
