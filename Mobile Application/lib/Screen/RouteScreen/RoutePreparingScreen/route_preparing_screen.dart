import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';

class RoutePreparingScreen extends StatefulWidget {
  final String route_uuid;

  const RoutePreparingScreen({Key? key, required this.route_uuid})
      : assert(route_uuid != null),
        super(key: key);

  @override
  _RoutePreparingScreenState createState() =>
      _RoutePreparingScreenState(route_uuid);
}

class _RoutePreparingScreenState extends State<RoutePreparingScreen> {
  late RouteBloc _routeBloc;
  String route_uuid;

  _RoutePreparingScreenState(this.route_uuid);

  @override
  void initState() {
    super.initState();
    _routeBloc = context.read<RouteBloc>();
    _routeBloc.add(RouteFetched(route_uuid: route_uuid));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(''),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Preparing'),
                Tab(text: 'Delivering'),
                Tab(text: 'Finished'),
              ],
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) =>
                                  QrcodeScanner(route_uuid: route_uuid)));
                          // .then((value) =>
                          //     BlocProvider.of<TaskStatusBloc>(context).add(
                          //         TaskStatusRefreshed(route_uuid: route_uuid)));
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 26.0,
                    ),
                  )),
            ],
          ),
          body: BlocListener<RouteBloc, RouteState>(
            listener: (context, state) {
              if (state is RouteUpdateError) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Status Update Error'),
                  backgroundColor: Colors.red,
                ));
              }
              if (state is RouteUpdateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Status Update Success'),
                  backgroundColor: Colors.green,
                ));
              }
            },
            child:
                BlocBuilder<RouteBloc, RouteState>(builder: (context, state) {
              if (state is RouteInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is RouteLoaded) {
                if (state.routes.isEmpty) {
                  return const Center(
                    child: Text('No Task'),
                  );
                }
                return TabBarView(
                  children: [
                    RoutePrepareList(state: state, route_uuid: route_uuid),
                    RouteDeliverList(state: state, route_uuid: route_uuid),
                    RouteFinishList(state: state, route_uuid: route_uuid),
                  ],
                );
              }
              if (state is RouteNeedRefresh) {
                BlocProvider.of<RouteBloc>(context)
                    .add(RouteRefreshed(route_uuid: route_uuid));
                BlocProvider.of<TaskStatusBloc>(context).add(
                    TaskStatusRefreshed(route_uuid: route_uuid));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          )),
    );
  }
}
