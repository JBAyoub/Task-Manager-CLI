Why This Project Exists

The goal of this project was not simply to create a task manager, but to build a complete command-line application that exercises many of Dart's core language features in a realistic scenario.

The application demonstrates experience with data modeling, persistence, asynchronous programming, CLI development, and software organization, providing a foundation for future Dart and Flutter projects.
"""

A command-line task management application built with Dart.

Tasker allows users to create, search, update, delete, and persist tasks directly from the terminal. The project was developed as a way to practice core Dart concepts including object-oriented programming, asynchronous programming, JSON serialization, file persistence, argument parsing, error handling, and CLI application design.

## Features

- Create new tasks
- Search tasks by title
- View all stored tasks
- Update existing tasks
  - Title
  - Status
  - Due date
  - Priority flag
- Delete tasks
- Persistent local storage using JSON files
- Command-line argument parsing
- Interactive terminal prompts
- Input validation and error handling
- Unique task identifiers

## Concepts Practiced

This project was primarily built to strengthen understanding of:

-Object-Oriented Programming

-Classes

-Constructors

-Factory constructors

-Enums

-Extensions

-Encapsulation

-Asynchronous Programming

-Futures

-async / await

-File I/O operations

-Data Persistence

-Reading JSON from disk

-Writing JSON to disk

-Object serialization

-Object deserialization

-Command-Line Development

-Argument parsing

-Flags and options

-Interactive user input

-Command dispatching

-Error Handling

-try/catch blocks

-Validation loops

-User-friendly error messages

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
