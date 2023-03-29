import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = context.read<TaskBloc>();
    _taskBloc.add(TaskFetched());
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      print(state);
      if (state is TaskInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is TaskLoaded) {
        if (state.tasks.isEmpty) {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<TaskBloc>(context).add(TaskRefreshed());
                  },
                  child: Stack(
                    children: <Widget>[ListView(), const Center(
                      child: Text('No Task'),
                    )
                    ],
                  ),
                ),
              )
            ],
          );
        }
        return Column(
          children: [
            TaskList(
              state: state,
            )
          ],
        );
      }
      return const Text('fail');
    });
  }
}
