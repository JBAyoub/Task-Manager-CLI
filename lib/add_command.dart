import 'package:args/args.dart';
import 'package:tasker/task.dart';

ArgParser addCommand = ArgParser();
ArgParser addParser = ArgParser()
  ..addFlag("help", abbr: "h", defaultsTo: false)
  ..addFlag("crucial", abbr: "c", defaultsTo: false)
  ..addOption("title", abbr: "t", mandatory: true)
  ..addOption("description", abbr: "d", defaultsTo: "No description was given.")
  ..addOption("due", abbr: "u", defaultsTo: DateTime.now().toIso8601String())
  ..addOption(
    "status",
    abbr: "s",
    defaultsTo: "fresh",
    allowed: TaskStatus.values.convert(),
  )
  ..addCommand("add", addCommand);

Future<void> add(List<String>? args) async {
  printAddUsage();
  if (args == null || args.isEmpty) {
    throw ArgParserException("No args were provided");
  } else if (args.contains("help") || args.contains("h")) {
    printAddUsage();
    return;
  } else {
    final results = addParser.parse(args);
    Task task = Task(
      title: results["title"],
      status: results["status"].toString().toLowerCase().getStatus(),
      description: results["description"],
      dueDate: DateTime.parse(results["due"]),
      crucial: results["crucial"],
    );
    await addTask(task);
  }
}

void printAddUsage() {
  print("Create a new task.");
  print("");
  print("Usage:");
  print("  tasker add [options]");
  print("");
  print("Options:");
  print("  -t, --title         Task title (required)");
  print("  -d, --description   Task description");
  print("  -u, --due-date      Due date (YYYY-MM-DD)");
  print("  -s, --status        Fresh | Ongoing | Delayed | Completed");
  print("  -c, --crucial       Marks task as crucial");
  print("");
  print("Example:");
  print(
    '  dart bin/tasker.dart add -t "Learn Dart" -d "Finish OOP tutorial" -u 2027-01-01 -c',
  );
}

extension on List<TaskStatus> {
  List<String>? convert() {
    if (isEmpty) {
      throw Exception("Did not find any task statues to convert");
    } else {
      List<String> tasksAsStrings = [];
      for (var taskStatus in this) {
        tasksAsStrings.add(taskStatus.name.toLowerCase());
      }
      return tasksAsStrings;
    }
  }
}
