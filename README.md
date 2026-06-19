The app should parse the command, validate the input, create a task object, save it to a local file, and print a clean result. You can add filters, sorting, task categories, recurring tasks, and export/import.

The user runs commands like:

> tasker add "study Dart" --priority high --due 2026-06-20
> tasker list
> tasker done 3
> tasker delete 5
> tasker search "study"