import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';

class RouteDeliveringTab extends StatelessWidget {
  final RouteLoaded state;
  final String route_uuid;

  const RouteDeliveringTab(
      {Key? key, required this.state, required this.route_uuid})
      : assert(state != null),
        assert(route_uuid != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<RouteBloc>(context)
                  .add(RouteRefreshed(route_uuid: route_uuid));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200]!,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RouteDeliveringList(
                    state: state,
                    route_uuid: route_uuid,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
