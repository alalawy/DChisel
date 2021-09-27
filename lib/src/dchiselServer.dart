import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_plus/shelf_plus.dart';

var errorData = 0;
var errorMessage;

var _routeGet = [];
var _routePost = [];
var _routePut = [];
var _routeDelete = [];
var _routePatch = [];
List<Function> _dataHandlerGet = [];
List<Function> _dataHandlerPost = [];
List<Function> _dataHandlerPut = [];
List<Function> _dataHandlerDelete = [];
List<Function> _dataHandlerPatch = [];

List<Map<String, dynamic>>? base = [];

class DChisel {
  void routeGet(String route, Function data) {
    _routeGet.add(route);
    _dataHandlerGet.add(data);
  }

  void routePost(String route, Function data) {
    _routePost.add(route);
    _dataHandlerPost.add(data);
  }

  void routePut(String route, Function data) {
    _routePut.add(route);
    _dataHandlerPut.add(data);
  }

  void routeDelete(String route, Function data) {
    _routeDelete.add(route);
    _dataHandlerDelete.add(data);
  }

  void routePatch(String route, Function data) {
    _routePatch.add(route);
    _dataHandlerPatch.add(data);
  }

  Future<void> serve({serverHost, serverPort}) async {
    var routes = Router().plus;

    RouterPlus routerData() {
      for (var i = 0; i < _routeGet.length; i++) {
        routes.get(_routeGet[i], _dataHandlerGet[i]);
      }
      for (var i = 0; i < _routePost.length; i++) {
        routes.post(_routePost[i], _dataHandlerPost[i]);
      }
      for (var i = 0; i < _routePut.length; i++) {
        routes.put(_routePut[i], _dataHandlerPut[i]);
      }
      for (var i = 0; i < _routeDelete.length; i++) {
        routes.delete(_routeDelete[i], _dataHandlerDelete[i]);
      }
      for (var i = 0; i < _routePatch.length; i++) {
        routes.delete(_routePatch[i], _dataHandlerPatch[i]);
      }

      return routes;
    }

    var server = await io.serve(
        routerData(), serverHost ?? 'localhost', serverPort ?? 8000);

    print('Serving at http://${server.address.host}:${server.port}');
  }
}
