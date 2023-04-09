import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final UserRepositories userRepositories;
  Map<String, OrderRoute>  routes = {};
  Map<String, Map<String, OrderStatus>> status = {};

  RouteBloc({required this.userRepositories})
      : assert(userRepositories != null),
        super(RouteInitial()) {
    on<RouteFetched>((event, emit) async {
      try {
        routes = await userRepositories.getTaskDetails(event.route_uuid);
        status = await userRepositories.getRouteStatus(event.route_uuid);
        emit(RouteLoaded(routes: routes, status: status));
      } catch (error) {
        emit(RouteError(error: error.toString()));
      }
    });
    on<RouteRefreshed>((event, emit) async {
      try{
        status = await userRepositories.getRouteStatus(event.route_uuid);
        emit(RouteLoaded(routes: routes, status: status));
      }catch (error){
        emit(RouteError(error: error.toString()));
      }
    });
    on<RouteStatusUpdate>((event, emit) async {
      try{
        await userRepositories.updateOrderStatus(event.scanData);
        emit(RouteUpdateSuccess());
      }catch (error) {
        emit(RouteUpdateError(error: error.toString()));
      }
      emit(RouteNeedRefresh());
    });
  }
}
