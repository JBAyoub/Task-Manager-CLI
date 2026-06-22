import 'dart:io';

import 'package:args/args.dart';
import 'package:tasker/command_runner.dart';
import 'package:tasker/task.dart';

ArgParser deleteCommand = ArgParser();
ArgParser deleteParser = ArgParser()
  ..addOption("title", abbr: "t")
  ..addCommand("delete", deleteCommand)
  ..addFlag("all", abbr: "a", defaultsTo: false);

Future<void> deleteTask(List<String>? inputArgs) async {
  String? taskTitle;
  if (inputArgs == null || inputArgs.isEmpty || inputArgs.length == 1) {
    printUsage();
    print("Please a task title: ");
    taskTitle = stdin.readLineSync() ?? '';
    if (taskTitle == '') {
      print("No task title was provided. Exiting");
      return;
    } else {
      await seekAndDestroy(taskTitle);
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

Future<void> seekAndDestroy(String title) async {
  final Task? t = await searchTask(title);
  if (t == null) {
    print("The task $title does not exist..Existing");
    return;
  }
  final List<Task> loadedTasks = await loadTasks();
  loadedTasks.removeWhere((element) => element.title == t.title);
  await saveTasks(loadedTasks);
}

Future<void> deleteAll() async {
  final List<Task> loadedTasks = await loadTasks()
    ..clear();
  await saveTasks(loadedTasks);
}
