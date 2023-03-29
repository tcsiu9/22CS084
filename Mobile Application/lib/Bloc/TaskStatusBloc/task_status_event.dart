part of 'task_status_bloc.dart';

abstract class TaskStatusEvent extends Equatable {
  const TaskStatusEvent();

  @override
  List<Object> get props => [];
}

class TaskStatusFetched extends TaskStatusEvent {
  final String status;

  TaskStatusFetched({required this.status});

  @override
  List<Object> get props => [status];

  @override
  String toString() => 'TaskStatusFetched {$status}';

}

class TaskStatusRefreshed extends TaskStatusEvent {
  final String route_uuid;

  TaskStatusRefreshed({required this.route_uuid});

  @override
  List<Object> get props => [route_uuid];

  @override
  String toString() => 'TaskStatusRefreshed {$route_uuid}';
}
