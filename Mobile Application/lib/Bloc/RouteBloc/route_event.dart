part of 'route_bloc.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();

  @override
  List<Object> get props => [];
}

class RouteFetched extends RouteEvent {
  final String route_uuid;

  const RouteFetched({required this.route_uuid});

  @override
  List<Object> get props => [route_uuid];

  @override
  String toString() => 'RouteFetched {$route_uuid}';
}

class RouteRefreshed extends RouteEvent {
  final String route_uuid;

  const RouteRefreshed({required this.route_uuid});

  @override
  List<Object> get props => [route_uuid];

  @override
  String toString() => 'RouteRefreshed {$route_uuid}';
}

class RouteStatusUpdate extends RouteEvent {
  final String scanData;
  final String route_uuid;

  RouteStatusUpdate({required this.scanData, required this.route_uuid});

  @override
  List<Object> get props => [scanData, route_uuid];

  @override
  String toString() => 'RouteStatusUpdate {$scanData, $route_uuid}';
}
