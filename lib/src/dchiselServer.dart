import 'dart:io';

import 'package:dchisel/dchisel.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_plus/shelf_plus.dart';

var errorData = 0;
var errorMessage;

List<Map<String, dynamic>>? base = [];

class DRoute {
  DRoute();
  var _routeGet = [];
  var _routePost = [];
  var _routePut = [];
  var _routeDelete = [];
  var _routePatch = [];
  List<Function>? _dataHandlerGet = [];
  List<Function>? _dataHandlerPost = [];
  List<Function>? _dataHandlerPut = [];
  List<Function>? _dataHandlerDelete = [];
  List<Function>? _dataHandlerPatch = [];

  var _routeMiddlewareGet = [];
  var _routeMiddlewarePost = [];
  var _routeMiddlewarePut = [];
  var _routeMiddlewareDelete = [];
  var _routeMiddlewarePatch = [];

  var _middleware = [];
  var _prefix = [];
  var _attach = [];
  var _attachDroutes = [];

  void get(String route, Function data, {middleware, prefix = ''}) {
    _routeGet.add(prefix + route);
    _dataHandlerGet!.add(data);
    _routeMiddlewareGet.add(middleware);
  }

  void post(String route, Function data, {middleware, prefix = ''}) {
    _routePost.add(prefix + route);
    _dataHandlerPost!.add(data);
    _routeMiddlewarePost.add(middleware);
  }

  void put(String route, Function data, {middleware, prefix = ''}) {
    _routePut.add(prefix + route);
    _dataHandlerPut!.add(data);
    _routeMiddlewarePut.add(middleware);
  }

  void delete(String route, Function data, {middleware, prefix = ''}) {
    _routeDelete.add(prefix + route);
    _dataHandlerDelete!.add(data);
    _routeMiddlewareDelete.add(middleware);
  }

  void patch(String route, Function data, {middleware, prefix = ''}) {
    _routePatch.add(prefix + route);
    _dataHandlerPatch!.add(data);
    _routeMiddlewarePatch.add(middleware);
  }

  void addMiddleware(middleware) {
    _middleware.add(middleware);
  }

  List allMiddleware() {
    return _middleware;
  }

  List all() {
    return [_routeGet, _routePost, _routePut, _routeDelete, _routePatch];
  }

  List allHandler() {
    return [
      _dataHandlerGet,
      _dataHandlerPost,
      _dataHandlerPut,
      _dataHandlerDelete,
      _dataHandlerPatch
    ];
  }

  List allRouteMiddleware() {
    return [
      _routeMiddlewareGet,
      _routeMiddlewarePost,
      _routeMiddlewarePut,
      _routeMiddlewareDelete,
      _routeMiddlewarePatch
    ];
  }
}

class DChisel {
  Future<HttpServer> serve({serverHost, serverPort, DRoute? getroutes}) async {
    var routes = Router().plus;
    var routes2 = Router().plus;

    List middleware = getroutes!.allMiddleware();
    List route = getroutes.all();
    List handler = getroutes.allHandler();
    List routeMiddleware = getroutes.allRouteMiddleware();

    RouterPlus routerData() {
      routes.use(corsHeaders());
      for (var i = 0; i < middleware.length; i++) {
        routes.use(middleware[i]);
      }

      for (var i = 0; i < route[0].length; i++) {
        routes.get(route[0][i], handler[0][i], use: routeMiddleware[0][i]);
      }
      for (var i = 0; i < route[1].length; i++) {
        routes.post(route[1][i], handler[1][i], use: routeMiddleware[0][i]);
      }
      for (var i = 0; i < route[2].length; i++) {
        routes.put(route[2][i], handler[2][i], use: routeMiddleware[0][i]);
      }
      for (var i = 0; i < route[3].length; i++) {
        routes.delete(route[3][i], handler[3][i], use: routeMiddleware[0][i]);
      }
      for (var i = 0; i < route[4].length; i++) {
        routes.patch(route[4][i], handler[4][i], use: routeMiddleware[0][i]);
      }
      for (var i = 0; i < route[4].length; i++) {
        routes.patch(route[4][i], handler[4][i], use: routeMiddleware[0][i]);
      }

      return routes;
    }

    Future<HttpServer> createServer() async {
      var server = await io.serve(
          routerData(), serverHost ?? 'localhost', serverPort ?? 8000);

      print('Serving at http://${server.address.host}:${server.port}');
      return server;
    }

    return createServer();
  }
}
