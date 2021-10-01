import 'package:process_run/shell.dart';

import 'arguments/create.dart';

void main(List<String> args) {
  if (args.length > 0) {
    if (args[0] == 'create') {
      if (args.length > 1) {
        create(project: args[1]);
      } else {
        create(project: 'dchisel-app');
      }
    }
  }
}
