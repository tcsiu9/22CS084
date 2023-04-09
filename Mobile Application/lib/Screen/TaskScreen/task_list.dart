import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/Screen/screen_export.dart';

class TaskList extends StatelessWidget {
  final TaskLoaded state;

  const TaskList({Key? key, required this.state})
      : assert(state != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = state.tasks;

    return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<TaskBloc>(context)
              .add(TaskRefreshed()); },
          child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                if(task.status != 'finished'){
                  return ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteScreen(task_uuid: task.uuid, status: task.status,))).then((value) => BlocProvider.of<TaskBloc>(context).add(TaskRefreshed()));
                    },
                    leading: Text((index + 1).toString()),
                    title: Text(task.uuid.toString()),
                    subtitle: Text(task.updated_at),
                  );
                }
              }),
        ));
  }
}
