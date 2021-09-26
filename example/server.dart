import 'package:dart_chisel/chisel.dart';

import 'routes/routes.dart';

void main(List<String> arguments) {
  Routes().routes();
  DChisel().serve(null, null); // SERVER
}
