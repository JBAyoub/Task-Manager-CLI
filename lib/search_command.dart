import 'dart:io';

import 'package:args/args.dart';
import 'package:tasker/task.dart';

ArgParser searchCommand = ArgParser();

ArgParser searchParser = ArgParser()
  ..addOption("title", abbr: "t")
  ..addFlag("help", abbr: "h", defaultsTo: false)
  ..addFlag("all", abbr: "a", defaultsTo: false)
  ..addCommand("search", searchCommand);

Future<void> displaySearch(List<String>? inputArgs) async {
  String? taskTitle;
  if (inputArgs == null || inputArgs.isEmpty || inputArgs.length == 1) {
    printUsage();
    print("Please a task title: ");
    taskTitle = stdin.readLineSync() ?? '';
    if (taskTitle == '') {
      print("No task title was provided. Exiting");

      return;
    } else {
      final ts = await searchTask(taskTitle.toLowerCase());
      print(ts ?? "No task that contains $taskTitle was found!");
    }
  } else {
    final searchResult = searchParser.parse(inputArgs);
    if (searchResult["title"] != null) {
      try {
        final ts = await searchTask(searchResult["title"].toLowerCase());
        print(ts ?? "No task titled ${searchResult["title"]} was found!");
      } catch (e) {
        if (e is Exception) {
          print(e.toString());
        }
      }
    }
    if (searchResult["all"]) {
      await displayAll();
    }
    if (searchResult["help"]) {
      printUsage();
    }
  }
}

Future<void> displayAll() async {
  List<Task?> loadedTasks = await loadTasks();
  if (loadedTasks.isEmpty) {
    print("There are no Tasks yet! Time to make some!");
    return;
  }
  for (var task in loadedTasks) {
    print(task);
  }
}

void printUsage() {
  print("will eventually print the functionality of the search command");
}
