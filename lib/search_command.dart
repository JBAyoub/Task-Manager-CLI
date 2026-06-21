import 'package:args/args.dart';
import 'package:tasker/task.dart';

ArgParser searchCommand = ArgParser();

ArgParser parser = ArgParser()
  ..addOption("title", abbr: "t")
  ..addFlag("help", abbr: "h", defaultsTo: false)
  ..addFlag("all", abbr: "a", defaultsTo: false)
  ..addCommand("search", searchCommand);

Future<void> displaySearch(List<String>? inputArgs) async {
  if (inputArgs == null || inputArgs.isEmpty || inputArgs.length == 1) {
    throw ArgParserException(
      "No arguments were provided for the command. Exiting.",
    );
  }
  ArgResults searchResult = parser.parse(inputArgs);
  if (searchResult["title"] != null) {
    final String taskTitle = searchResult["title"];
    try {
      final Task? t = await searchTask(taskTitle.toLowerCase());
      print(t);
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

Future<void> displayAll() async {
  List<Task?> loadedTasks = await loadTasks();
  if (loadedTasks.isEmpty) {
    print("There are no Tasks yet! Time to make some!");
  }
  for (var task in loadedTasks) {
    print(task);
  }
}

void printUsage() {
  print("will eventually print the functionality of the search command");
}
