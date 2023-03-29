part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskError extends TaskState{
  final String error;

  const TaskError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TaskError {$error}';
}

class TaskLoaded extends TaskState {
  const TaskLoaded({
    this.tasks = const <Task>[],
  });

  final List<Task> tasks;

  TaskLoaded copyWith({List<Task>? tasks}) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [tasks];
}
