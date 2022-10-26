import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dchisel/dchisel.dart';

Map<String, dynamic> encodeMap(Map<String, dynamic> map) {
  map.forEach((key, value) {
    if (value is DateTime) {
      map[key] = value.toString();
    }
  });
  return map;
}

Response resOk(dynamic data) {
  return Response.ok(
      jsonEncode({'error': 0, 'data': data, 'message': 'Success'}),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType});
}

Response resForbidden(String message) {
  return Response.forbidden(
      jsonEncode({'error': 1, 'data': [], 'message': message}),
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType});
}

String generateSalt([int length = 32]) {
  final rand = Random.secure();
  final saltBytes = List<int>.generate(length, (_) => rand.nextInt(256));
  return base64Encode(saltBytes);
}

String hashPassword(String password, String salt) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final saltBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  final diggest = hmac.convert(saltBytes);
  return diggest.toString();
}

String generateJwt(String subject, String issuer, String secret,
    {required String salt}) {
  final jwt = JWT({'iat': DateTime.now().millisecondsSinceEpoch, 'salt': salt},
      subject: subject, issuer: issuer);
  return jwt.sign(SecretKey(secret));
}

dynamic verifyJwt(String token, String secret) {
  if (token != "") {
    try {
      final jwt = JWT.verify(token, SecretKey(secret));
      return jwt;
    } on JWTExpiredError {
      print('jwt expired');
    } on JWTError catch (ex) {
      return null;
      print(ex.message); // ex: invalid signature
    }
  } else {
    return null;
  }
}

Middleware handleAuth(String secret) {
  return (Handler innerHandler) {
    return (Request request) async {
      final authHeader = request.headers['Authorization'];
      var token, jwt;
      if (authHeader != null && authHeader.startsWith('Bearer ')) {
        token = authHeader.substring(7);
        jwt = verifyJwt(token, secret);
      }

      final updateRequest = request.change(context: {
        'authDetails': jwt,
      });

      return await innerHandler(updateRequest);
    };
  };
}

Middleware checkAuth() {
  return createMiddleware(requestHandler: (Request request) {
    if (request.context['authDetails'] == null ||
        request.context['authDetails'] == '') {
      Response.forbidden('Not authorize');
    }
    return Response.forbidden('Not authorize');
  });
}

String getRandString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

File decodeBase64(String img64, String imageType) {
  final decodedBytes = base64Decode(img64);
  String filename = getRandString(10);
  var file = Io.File("assets/$imageType/$filename.png");
  file.writeAsBytesSync(decodedBytes);

  return file;
}
