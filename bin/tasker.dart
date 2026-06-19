import 'dart:ffi';
import 'dart:io'; // Add this line at the top

const version = "0.0.1";
void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == "help") {
    printUsage();
  } else if (arguments.first == "-v" || arguments.first == "version") {
    print("Tasker CLI Version: $version");
  } else if (arguments.first == "search") {
    print("Search command detected");
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchTask(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "You can use this app to manage & perform all kinds of operations on your tasks",
  );
  print("Syntax: dart /bin/tasker.dart <command>");
  print("Available commands: 'add','search','help'");
}

void searchTask(List<String>? input) {
  final String task;
  if (input == null || input.isEmpty) {
    print("Please provide a task Title to search");
    task = stdin.readLineSync() ?? '';
    print("you seached the task: $task \n -->Implementation will come later");
  } else {
    task = input.join(' ');
  }
  print('Looking up Tasks about "$task". Please wait.');
  print('Here ya go!');
  print('(Pretend this is "$task")');
}
