import 'dart:convert';
import 'dart:io';
import 'package:id_generator/id_generator.dart';
import 'package:args/args.dart';

class Task {
  String id;
  String title;
  TaskStatus status;
  String? description;
  DateTime? dueDate;
  bool crucial = false;

  Task({
    String? id,
    required this.title,
    required this.status,
    required this.description,
    required this.dueDate,
    required this.crucial,
  }) : id = id ?? IDGenerator.customMix(10, [IdgEnum.nums, IdgEnum.alpha]);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'].toString(),
      status: json['status'].toString().getStatus(),
      description: json['description'].toString(),
      dueDate: DateTime.tryParse(json['due date']),
      crucial: json["crucial"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "title": title,
      "status": status.name,
      "description": description,
      "due date": dueDate?.toIso8601String(),
      "crucial": crucial,
    };
  }

  @override
  String toString() {
    return " Task ID:$id\n Task title: $title \n --->Description: $description \n --->Due Date: $dueDate \n --->Status: ${status.name} \n \n \n";
  }
}

Future<List<Task?>?> searchTask(String taskTitle) async {
  if (taskTitle.isEmpty) {
    throw ArgParserException("No title was provided. Exiting");
  }
  List<Task?>? results = await getTasks(taskTitle);
  return results;
}

Future<List<Task?>?> getTasks(String taskName) async {
  final taskList = await loadTasks();
  final List<Task> tasksFound = taskList
      .where((t) => t.title.toLowerCase().contains(taskName))
      .toList();
  return tasksFound;
}

Future<void> checkFileOrCreate(File file) async {
  final dir = Directory('data');

  if (!await dir.exists()) {
    print('Creating data directory...');
    await dir.create(recursive: true);
  }

  if (!await file.exists()) {
    print('Creating tasks.json...');
    await file.writeAsString('[]');
  }
}

Future<List<Task>> loadTasks() async {
  await checkFileOrCreate(File("data/tasks.json"));
  final decoded =
      jsonDecode(await File("data/tasks.json").readAsString()) as List;
  return decoded.map((json) => Task.fromJson(json)).toList();
}

Future<void> addTask(Task task) async {
  final tasks = await loadTasks();
  tasks.add(task);
  await saveTasks(tasks);
}

Future<void> saveTasks(List<Task> tasks) async {
  final file = File("data/tasks.json");
  await checkFileOrCreate(file);
  final jsonList = tasks.map((task) => task.toJson()).toList();
  await file.writeAsString(jsonEncode(jsonList));
}

// ignore: constant_identifier_names
enum TaskStatus { Completed, Ongoing, Delayed, Fresh }

extension GetStat on String {
  TaskStatus getStatus() {
    switch (toLowerCase()) {
      case ('' || "fresh"):
        return TaskStatus.Fresh;
      case 'completed':
        return TaskStatus.Completed;
      case 'ongoing':
        return TaskStatus.Ongoing;
      case 'delayed':
        return TaskStatus.Delayed;
      default:
        throw FormatException('Invalid status');
    }
  }
}
