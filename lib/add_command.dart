import 'package:args/args.dart';
import 'package:tasker/task.dart';

ArgParser addCommand = ArgParser();
ArgParser parser = ArgParser()
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
  if (args == null || args.isEmpty) {
    throw ArgParserException("No args were provided");
  } else if (args.contains("help") || args.contains("h")) {
    printAddUsage();
    return;
  } else {
    ArgResults results = parser.parse(args);
    var taskExists = await searchTask(results["title"]);
    if (taskExists == null) {
      Task task = Task(
        title: results["title"],
        status: results["status"].toString().toLowerCase().getStatus(),
        description: results["description"],
        duteDate: DateTime.parse(results["due"]),
        crucial: results["crucial"],
      );
      await addTask(task);
    }
  }
}

void printAddUsage() {
  print("Will Later add functionality descirption and help to this func");
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
