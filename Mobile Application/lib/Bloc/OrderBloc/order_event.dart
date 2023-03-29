part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderFetched extends OrderEvent {
  final String route_uuid;

  const OrderFetched({required this.route_uuid});

  @override
  List<Object> get props => [route_uuid];

  @override
  String toString() => 'OrderFetched {$route_uuid}';
}

class OrderRefreshed extends OrderEvent {
  final String route_uuid;

  const OrderRefreshed({required this.route_uuid});

  @override
  List<Object> get props => [route_uuid];

  @override
  String toString() => 'OrderRefreshed {$route_uuid}';
}
