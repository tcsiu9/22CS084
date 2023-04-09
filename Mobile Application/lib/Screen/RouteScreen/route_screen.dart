import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Screen/screen_export.dart';

class RouteScreen extends StatefulWidget {
  final String task_uuid;
  final String status;

  RouteScreen({Key? key, required this.task_uuid, required this.status})
      : assert(task_uuid != null),
        assert(status != null),
        super(key: key);

  @override
  State<RouteScreen> createState() => _RouteScreenState(task_uuid, status);
}

class _RouteScreenState extends State<RouteScreen> {
  String route_uuid;
  String status;
  late TaskStatusBloc _taskStatusBloc;

  _RouteScreenState(this.route_uuid, this.status);

  @override
  void initState() {
    super.initState();
    _taskStatusBloc = context.read<TaskStatusBloc>();
    _taskStatusBloc.add(TaskStatusFetched(status: status));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskStatusBloc, TaskStatusState>(
        builder: (context, state) {
      print(state);
      if (state is TaskStatusPreparing) {
        return RoutePreparingScreen(route_uuid: route_uuid);
        // return Text('TEST');
      }
      if (state is TaskStatusDeliverying) {
        return RouteDeliveringScreen(
          route_uuid: route_uuid,
        );
      }
      if (state is TaskStatusFinished) {
        return const RouteFinishScreen();
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
