import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/Screen/screen_export.dart';

class RouteFinishList extends StatelessWidget {
  final RouteLoaded state;
  final String route_uuid;

  const RouteFinishList(
      {Key? key, required this.state, required this.route_uuid})
      : assert(state != null),
        assert(route_uuid != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, OrderRoute> routes = state.routes;
    // Map<String, OrderRoute> routes_list = routes.values.toList();
    List<OrderStatus> orderStatus = state.status['finished']!.values.toList();

    return Column(
      children: [
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<RouteBloc>(context)
                      .add(RouteRefreshed(route_uuid: route_uuid));
                },
                child: orderStatus.isNotEmpty
                    ? ListView.builder(
                    itemCount: orderStatus.length,
                    itemBuilder: (context, index) {
                      OrderStatus status = orderStatus[index];
                      OrderRoute route = routes[status.uuid]!;
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => order(orderInfo: route)));
                          BlocProvider.of<OrderBloc>(context)
                              .add(OrderFetched(route_uuid: route.uuid));
                        },
                        title: Text(
                          route.uuid,
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        subtitle: Text('${route.delivery1} ${route.delivery2}'),
                        trailing: Text(status.status),
                      );
                    })
                    : const Center(child: Text('Empty')))),
      ],
    );
  }
}
