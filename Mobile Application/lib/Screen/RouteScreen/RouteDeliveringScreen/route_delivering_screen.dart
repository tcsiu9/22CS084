import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';

class RouteDeliveringScreen extends StatefulWidget {
  final String route_uuid;

  const RouteDeliveringScreen({Key? key, required this.route_uuid})
      : assert(route_uuid != null),
        super(key: key);

  @override
  State<RouteDeliveringScreen> createState() =>
      _RouteDeliveringScreenState(route_uuid);
}

class _RouteDeliveringScreenState extends State<RouteDeliveringScreen> {
  late RouteBloc _routeBloc;
  String route_uuid;
  var _selectedPageIndex = 0;

  _RouteDeliveringScreenState(this.route_uuid);

  @override
  void initState() {
    super.initState();
    _routeBloc = context.read<RouteBloc>();
    _routeBloc.add(RouteFetched(route_uuid: route_uuid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ship To'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) =>
                              QrcodeScanner(route_uuid: route_uuid)))
                      .then((value) => BlocProvider.of<TaskStatusBloc>(context)
                          .add(TaskStatusRefreshed(route_uuid: route_uuid)));
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
        },
        child: BlocBuilder<RouteBloc, RouteState>(
          builder: (context, state) {
            if (state is RouteInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is RouteLoaded) {
              return RouteBottomTab(
                state: state,
                route_uuid: route_uuid,
                selectedPageIndex: _selectedPageIndex,
              );
            }
            if (state is RouteNeedRefresh) {
              BlocProvider.of<RouteBloc>(context)
                  .add(RouteRefreshed(route_uuid: route_uuid));
            }
            return const Text('Fail');
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Delivery List'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Navigation'),
        ],
      ),
    );
  }
}
