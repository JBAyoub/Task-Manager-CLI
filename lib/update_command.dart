import 'dart:io';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:tasker/task.dart';

void printUsage() {
  print("This will eventually print the usage of the update command");
}

ArgParser updateCommand = ArgParser();
ArgParser parser = ArgParser()
  ..addCommand("update", updateCommand)
  ..addOption("title", abbr: "t");

Future<void> update(List<String>? inputArgs) async {
  String? taskTitle;
  if (inputArgs == null || inputArgs.isEmpty || inputArgs.length == 1) {
    printUsage();
    print("Please a task title to update: ");
    taskTitle = stdin.readLineSync() ?? '';
    if (taskTitle == '') {
      print("No task title was provided. Exiting");
      return;
    } else {
      await updateTask(taskTitle);
    }
  } else {
    ArgResults results = parser.parse(inputArgs);
    updateTask(results['title'].toString());
  }
}

Future<void> updateTask(String taskTitle) async {
  List<Task>? loadedTasks = await loadTasks();
  if (loadedTasks.isEmpty) {
    print(
      "You currently have no tasks stored :( \n Try creating some with the <add> command!",
    );
    return;
  }
  final int index = loadedTasks.indexWhere(
    (t) => t.title.toLowerCase() == taskTitle.toLowerCase(),
  );
  if (index == -1) {
    print("The task $taskTitle could not be found. Exiting...");
  } else {
    final Task t = loadedTasks[index];
    print("Task $taskTitle found! What would you like to update? \n");
    print("1. Title");
    print("2. Status");
    print("3. Due Date");
    print("4. Crucial");
    switch (stdin.readLineSync()) {
      case "1":
        updateTitle(t);
        break;
      case "2":
        updateStatus(t);
        break;
      case "3":
        updateDate(t);
        break;
      case "4":
        updateCrucial(t);
        break;
      default:
        print("Please choose a correct number");
        return;
    }
  }
  await saveTasks(loadedTasks);
  print("Task updated successfully!");
}

void updateCrucial(Task t) {
  String? crucial;
  do {
    print("Please state whether the task is crucial or not!");
    print("1.Crucial");
    print("0. Not Crucial");
    crucial = stdin.readLineSync();
  } while (crucial == null ||
      crucial.trim() == '' ||
      crucial.trim() != '1' ||
      crucial.trim() != '0');
  t.crucial = crucial == '1' ? true : false;
}

void updateDate(Task t) {
  final DateTime dueDate = askForDate();
  t.duteDate = dueDate;
}

void updateStatus(Task t) {
  while (true) {
    print("Current Status: ${t.status.name}");
    print("Allowed values: [Fresh, Ongoing, Delayed, Completed]");
    final input = stdin.readLineSync() ?? '';
    try {
      t.status = input.getStatus();
      break;
    } on FormatException {
      print("Invalid status. Try again.\n");
    }
  }
}

void updateTitle(Task t) {
  while (true) {
    print("Enter a title");

    final input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print("Title cannot be empty.");
      continue;
    }
    t.title = input;
    break;
  }
}

DateTime askForDate() {
  while (true) {
    print("Enter a date (YYYY-MM-DD):");
    final input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print("Date cannot be empty.");
      continue;
    }
    try {
      return DateTime.parse(input);
    } on FormatException {
      print("Invalid date format. Use YYYY-MM-DD.");
    }
  }
}
