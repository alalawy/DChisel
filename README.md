# DChisel Dart Framework  
DChisel is simple Dart Framework for creating REST API

[![pub package](https://img.shields.io/pub/v/dchisel.svg)](https://pub.dev/packages/dchisel) 

## Features

* Custom host server and port
* GET, POST, PUT, DELETE, PATCH Routes
* ORM CRUD to PostgreSQL

## Usage

To add the dchisel to your Dart application read the [install](https://pub.dev/packages/DCHISEL/install) instructions.

#### Host Server
Default host is "localhost" and port 8000
```dart
import 'package:dchisel/dchisel.dart';

Future<void> main(List<String> arguments) async {
  DChisel().serve();
}
```
If you want to change the host to 0.0.0.0 and port to 5555 you can use :

```dart
 DChisel().serve(serverHost: '0.0.0.0', serverPort: 5555);
```

#### GET Route
```dart
DChisel().routeGet('/hello', (Request request) {
    return 'Hello, World';
});
```
GET with param you can use :
```dart
DChisel().routeGet('/getparam/<name>', (Request request, String name) {
    return 'Hello, $name';
});
```

#### POST Route
```dart
DChisel().routePost('/hello', (Request request) async {
    return 'Hello, World';
});
```
If you want to get Body value from your POST request, use :
```dart
var body = await request.body.asJson;
```
If you want to get Header value from your POST request, use :
```dart
var headers = await request.headers;
```
#### PUT Route
```dart
DChisel().routePut('/hello/<name>', (Request request, String name) async {
  return 'Hello, $name';
});
```
PUT also can get Header and Body request
```dart
var headers = await request.headers;
var body = await request.body.asJson;
```
#### DELETE Route
```dart
DChisel().routeDelete('/hello/<name>', (Request request, String name) async {
  return 'Hello, $name';
});
```

## Dchisel ORM
For now, DChisel only support PostgreSQL

#### DB Config
```dart
DChiselDB().configDB(
    host: 'your_host',
    db: 'your_db_name',
    port: your_port, //integer
    username: 'your_db_username',
    password: 'your_db_password');
```
#### Get All Data
```dart
DChiselDB().getAll('your_table_name');
```
#### Get Data With Custom Column and Filter
```dart
DChiselDB().getOption('your_table_name', 
    column: 'your_column1,your_column2', 
    where: ['your_column_name', 'your_filter_value']);
```
If you want filter contains, just add % into your filter value, example :
```dart
'%your_filter_value%'
```

#### Create Data
```dart
DChiselDB().create('users', data: {
    'your_column_name': 'your_value'
});
```

#### Update Data
```dart
DChiselDB().update('users', data: {
    'your_column_name': 'your_value'
}, where: ['your_filter_column_name', 'your_filter_value']);
```

#### Delete Data
```dart
DChiselDB().deleteAll('your_table_name');
```

#### Delete Data Custom Filter
```dart
DChiselDB().deleteOption('your_table_name', where: ['your_filter_column_name', 'your_filter_value']);
```

## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/alalawy/DChisel/issues) page. Commercial support is available, you can contact us at <alphacsoft@gmail.com>.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](../CONTRIBUTING.md) and send us your [pull request](https://github.com/alalawy/DChisel/pulls).

## Author

This dchisel framework for Dart is developed by [Alphacsoft](https://alphacsoft.com).
