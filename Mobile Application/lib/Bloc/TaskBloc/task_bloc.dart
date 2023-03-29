import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final UserRepositories userRepositories;

  TaskBloc({required this.userRepositories})
      : assert(userRepositories != null),
        super(TaskInitial()) {
    on<TaskFetched>((event, emit) async {
      List<Task> tasks;
      try{
        tasks = await userRepositories.getAllTasks();
        emit(TaskLoaded(tasks: tasks));
      }catch(error){
        emit(TaskError(error: error.toString()));
      }
    });
    on<TaskRefreshed>((event, emit) async {
      List<Task> tasks;
      try{
        tasks = await userRepositories.getAllTasks();
        emit(TaskLoaded(tasks: tasks));
      }catch(error){
        emit(TaskError(error: error.toString()));
      }
    });
  }
}
