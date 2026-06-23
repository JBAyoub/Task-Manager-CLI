# Tasker CLI

A command-line task management application built with Dart.

Tasker allows users to create, search, update, delete, and persist tasks directly from the terminal. The project was developed as a way to practice core Dart concepts including object-oriented programming, asynchronous programming, JSON serialization, file persistence, argument parsing, error handling, and CLI application design.

## Features

- Create new tasks
- Search tasks by title
- View all stored tasks
- Update existing tasks
- Delete tasks
- Persistent local storage using JSON files
- Command-line argument parsing
- Interactive terminal prompts
- Input validation and error handling
- Unique task identifiers

## Technologies Used

- Dart
- `args` package
- `dart:io`
- `dart:convert`

## Project Structure

```text
lib/
├── task.dart
├── add_command.dart
├── delete_command.dart
├── search_command.dart
├── update_command.dart
├── command_runner.dart

data/
└── tasks.json

bin/
└── tasker.dart
```

## Example Commands

```bash
dart bin/tasker.dart add -t "Learn Dart"
dart bin/tasker.dart search -t "dart"
dart bin/tasker.dart search -a
dart bin/tasker.dart update -t "Learn Dart"
dart bin/tasker.dart delete -t "Learn Dart"
```

## Concepts Practiced

- Classes and Objects
- Constructors and Factory Constructors
- Enums
- Extensions
- Async/Await
- Futures
- JSON Serialization
- File Persistence
- Error Handling
- CLI Argument Parsing

## Future Improvements

- Filtering by status
- Sorting by due date
- SQLite support
- Unit testing
- Repository pattern
- Categories and tags

## Why This Project Exists

The goal of this project was not simply to create a task manager, but to build a complete command-line application that exercises many of Dart's core language features in a realistic scenario.

The application demonstrates experience with data modeling, persistence, asynchronous programming, CLI development, and software organization, providing a foundation for future Dart and Flutter projects.
