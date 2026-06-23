import 'package:args/args.dart';
import 'package:tasker/add_command.dart';
import 'package:tasker/delete_command.dart';
import 'package:tasker/search_command.dart';
import 'package:tasker/update_command.dart';

Future<void> run(List<String>? inputArgs) async {
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
  print("Tasker - A simple CLI task manager");
  print("");
  print("Usage:");
  print("dart bin/tasker.dart <command> [options]");
  print("");
  print("Commands:");
  print("  add       Create a new task");
  print("  search    Search for existing tasks");
  print("  update    Update an existing task");
  print("  delete    Delete a task");
  print("  help      Show this help menu");
  print("");
  print("Examples:");
  print('  dart bin/tasker.dart add -t "Learn Dart"');
  print('  dart bin/tasker.dart search -t "dart"');
  print('  dart bin/tasker.dart update -t "Learn Dart"');
  print('  dart bin/tasker.dart delete -t "Learn Dart"');
}
