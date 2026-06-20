import 'package:args/args.dart';
import 'package:tasker/task.dart';

ArgParser addCommand = ArgParser();
ArgParser parser = ArgParser()
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
  print(TaskStatus.values.convert());
  if (args == null || args.isEmpty) {
    throw ArgParserException("No args were provided");
  }
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
