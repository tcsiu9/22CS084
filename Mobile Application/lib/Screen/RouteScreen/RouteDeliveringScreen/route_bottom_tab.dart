import 'package:flutter/material.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Screen/screen_export.dart';

class RouteBottomTab extends StatelessWidget {
  final RouteLoaded state;
  final String route_uuid;
  final int selectedPageIndex;

  const RouteBottomTab(
      {Key? key,
      required this.state,
      required this.route_uuid,
      required this.selectedPageIndex})
      : assert(state != null),
        assert(route_uuid != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedPageIndex == 0) {
      return RouteDeliveringTab(state: state, route_uuid: route_uuid);
    } else if (selectedPageIndex == 1) {
      return RouteNavigationTab(routeLoaded: state, route_uuid: route_uuid);
    }
    return const Center(child: Text('Fail'));
  }
}
