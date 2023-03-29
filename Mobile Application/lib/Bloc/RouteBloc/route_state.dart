part of 'route_bloc.dart';

abstract class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteInitial extends RouteState {}

class RouteError extends RouteState {
  final String error;

  const RouteError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RouteError {$error}';
}

class RouteUpdateError extends RouteState {
  final String error;

  const RouteUpdateError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RouteUpdateError {$error}';
}

class RouteLoaded extends RouteState {
  final Map<String, OrderRoute> routes;
  final Map<String, Map<String, OrderStatus>> status;

  const RouteLoaded({
    this.routes = const <String, OrderRoute>{},
    this.status = const <String, Map<String, OrderStatus>>{},
  });


  RouteLoaded copyWith({Map<String, OrderRoute>? routes, Map<String, Map<String, OrderStatus>>? status}) {
    return RouteLoaded(
      routes: routes ?? this.routes,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [routes, status];
}

class RouteNeedRefresh extends RouteState {}
