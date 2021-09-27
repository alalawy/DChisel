import 'package:dchisel/dchisel.dart';
import 'routes/routes.dart';

Future<void> main(List<String> arguments) async {
  Routes().routes();
  DChisel().serve();
}
