import 'package:args/args.dart';
import 'task.dart';

var parser = ArgParser()
  ..addFlag("crucial", abbr: "c", defaultsTo: false)
  ..addOption("title", abbr: "t", mandatory: true)
  ..addOption("description", abbr: "d", defaultsTo: "No description was given.")
  ..addOption(
    "due",
    abbr: "u",
    defaultsTo: DateTime.now().toIso8601String().toString(),
  )
  ..addOption(
    "status",
    abbr: "s",
    defaultsTo: "fresh",
    allowed: TaskStatus.values.convert(),
  )
  ..addCommand("add");

extension on List<TaskStatus> {
  List<String>? convert() {
    if (isEmpty) {
      throw Exception("Did not find any task statues to convert");
    } else {
      List<String> tasksAsStrings = [];
      for (var taskStatus in this) {
        tasksAsStrings.add(taskStatus.name);
      }
      return tasksAsStrings;
    }
  }
}

void run(List<String>? inputArgs) {
  const version = "0.0.1";
  if (inputArgs == null || inputArgs.isEmpty || inputArgs.first == "help") {
    print("No arguments were provided. Exiting.");
    printUsage();
  } else if (inputArgs.first == "-v" || inputArgs.first == "version") {
    print("Tasker CLI Version: $version");
  }
  var results = parser.parse(inputArgs!);
  print("status is ${results.option("status")}");
  print("due is ${results.option("due")}");
  print("crucial is ${results.flag("crucial")}");
  print("description is ${results.option("description")}");
  print("title is ${results.option("title")}");
  print("command is ${results.command?.name}");
}

void printUsage() {
  print(
    "You can use this app to Create & Perform all kinds of operations on your tasks",
  );
  print("Syntax: dart /bin/tasker.dart <command>");
  print("Available commands: 'add','search','help'");
}
