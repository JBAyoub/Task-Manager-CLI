import 'package:args/args.dart';
import 'package:tasker/add_command.dart';
import 'package:tasker/delete_command.dart';
import 'package:tasker/search_command.dart';
import 'package:tasker/update_command.dart';

void run(List<String>? inputArgs) async {
  const version = "0.0.1";
  if (inputArgs == null || inputArgs.isEmpty || inputArgs.first == "help") {
    printUsage();
    throw ArgParserException("No arguments were provided. Exiting.");
  } else if (inputArgs.first == "-v" || inputArgs.first == "version") {
    print("Tasker CLI Version: $version");
  }

  switch (inputArgs.first) {
    case "add":
      await add(inputArgs);
      break;
    case "delete":
      await deleteTask(inputArgs);
      break;
    case "search":
      await displaySearch(inputArgs);
      break;
    case "update":
      await update(inputArgs);
  }
}

void printUsage() {
  print(
    "You can use this app to Create & Perform all kinds of operations on your tasks",
  );
  print("Syntax: dart /bin/tasker.dart <command>");
  print("Available commands: 'add','search','help'");
}
