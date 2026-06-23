import 'dart:io';

import 'package:args/args.dart';
import 'package:tasker/search_command.dart';
import 'package:tasker/task.dart';

ArgParser deleteCommand = ArgParser();
ArgParser deleteParser = ArgParser()
  ..addOption("ID", abbr: "i")
  ..addCommand("delete", deleteCommand)
  ..addFlag("all", abbr: "a", defaultsTo: false);

Future<void> deleteTask(List<String>? inputArgs) async {
  String? id;
  if (inputArgs == null || inputArgs.isEmpty || inputArgs.length == 1) {
    await displayAll();
    print("Please enter the Task's ID to delete: ");
    id = stdin.readLineSync() ?? '';
    if (id == '') {
      printDeleteUsage();
      print("No Task ID was provided. Exiting");

      return;
    } else {
      await seekAndDestroy(id);
    }
  } else {
    final results = deleteParser.parse(inputArgs);
    if (results['all']) {
      await deleteAll();
      return;
    }
    seekAndDestroy(results["title"].toString());
  }
}

void printDeleteUsage() {
  print("Delete a task.");
  print("");
  print("Usage:");
  print("  tasker delete [options]");
  print("");
  print("Options:");
  print("  -t, --title     Title of the task to delete");
  print("");
  print("Example:");
  print('  dart bin/tasker.dart delete -t "Learn Dart"');
}

Future<void> seekAndDestroy(String id) async {
  final List<Task> ts = await loadTasks();
  ts.removeWhere((element) => element.id == id);
  await saveTasks(ts);
}

Future<void> deleteAll() async {
  final List<Task> loadedTasks = await loadTasks()
    ..clear();
  await saveTasks(loadedTasks);
}
