import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

part 'task_status_event.dart';

part 'task_status_state.dart';

class TaskStatusBloc extends Bloc<TaskStatusEvent, TaskStatusState> {
  final UserRepositories userRepositories;

  TaskStatusBloc({required this.userRepositories})
      : assert(userRepositories != null),
        super(TaskStatusInitial()) {
    on<TaskStatusFetched>((event, emit) {
      switch (event.status) {
        case 'preparing':
          {
            emit(TaskStatusPreparing());
          }
          break;
        case 'delivering':
          {
            emit(TaskStatusDeliverying());
          }
          break;
        case 'finished':
          {
            emit(TaskStatusFinished());
          }
          break;
        default:
          {
            emit(TaskStatusError());
          }
          break;
      }
    });
    on<TaskStatusRefreshed>((event, emit) async{
      Task task = await userRepositories.getTask(event.route_uuid);
      switch (task.status) {
        case 'preparing':
          {
            emit(TaskStatusPreparing());
          }
          break;
        case 'delivering':
          {
            emit(TaskStatusDeliverying());
          }
          break;
        case 'finished':
          {
            emit(TaskStatusFinished());
          }
          break;
        default:
          {
            emit(TaskStatusError());
          }
          break;
      }
    });
  }
}
