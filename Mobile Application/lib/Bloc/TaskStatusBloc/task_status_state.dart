part of 'task_status_bloc.dart';

abstract class TaskStatusState extends Equatable {
  const TaskStatusState();

  @override
  List<Object> get props => [];
}

class TaskStatusInitial extends TaskStatusState {}

class TaskStatusPreparing extends TaskStatusState {}

class TaskStatusDeliverying extends TaskStatusState {}

class TaskStatusFinished extends TaskStatusState {}

class TaskStatusNeedRefresh extends TaskStatusState {}

class TaskStatusError extends TaskStatusState {}