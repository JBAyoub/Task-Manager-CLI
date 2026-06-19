import 'dart:convert';
import 'dart:io';

class Task {
  final String title;
  final TaskStatus status;
  final String description;
  final DateTime? duteDate;

  Task({
    required this.title,
    required this.status,
    required this.description,
    required this.duteDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      status: json['status'].toString().getStatus(),
      description: json['description'].toString(),
      duteDate: DateTime.tryParse(json['due date']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      title: title,
      status: status.name,
      description: description,
      duteDate: duteDate?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Task title: $title \n --->Description: $description \n --->Due Date: $duteDate \n --->Status: ${status.name} \n \n";
  }
}

void searchTask(List<String>? input) async {
  final String taskTitle;
  if (input == null || input.isEmpty) {
    print("Please provide a task Title to search");
    taskTitle = stdin.readLineSync() ?? '';
    print(
      "you seached the task: $taskTitle \n -->Implementation will come later",
    );
  } else {
    taskTitle = input.join(' ');
  }
  print('Looking up Tasks about "$taskTitle". Please wait.');
  print('Here ya go!');
  var results = await getTask(taskTitle);
  print(results.length > 1 ? results : results.first);
}

Future<List<Task>> getTask(String taskName) async {
  final taskList = await loadTasks();
  List<Task> listOfTasks = [];
  listOfTasks.addAll(taskList.where((task) => task.title == taskName));
  return listOfTasks;
}

Future<List<Task>> loadTasks() async {
  final file = File("data/tasks.json");
  if (!await file.exists()) {
    final dir = Directory("data");
    if (!await dir.exists()) {
      await dir.create(recursive: true);
      await file.writeAsString('[]');
    }
  }
  final decoded = jsonDecode(await file.readAsString()) as List;
  return decoded.map((json) => Task.fromJson(json)).toList();
}

// ignore: constant_identifier_names
enum TaskStatus { Completed, Ongoing, Delayed, Fresh }

extension GetStat on String {
  TaskStatus getStatus() {
    switch (toLowerCase()) {
      case '':
        return TaskStatus.Fresh;
      case 'completed':
        return TaskStatus.Completed;
      case 'ongoing':
        return TaskStatus.Ongoing;
      case 'delayed':
        return TaskStatus.Delayed;
      default:
        return TaskStatus.Fresh;
    }
  }
}
