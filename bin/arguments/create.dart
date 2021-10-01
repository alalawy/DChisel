import 'package:process_run/shell.dart';

void create({project}) async {
  var shell = Shell();

  await shell
      .run('''git clone https://github.com/alalawy/DChisel.git $project''');
  await shell.run(''' rm -rf ./$project/.git ''');
}
